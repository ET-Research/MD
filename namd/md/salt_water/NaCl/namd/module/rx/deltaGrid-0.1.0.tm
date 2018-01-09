namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm


#---------------------------------------------
# Get energies from self and neighbors
#   before and after the exchange
#
# Args:
#   neighborAddress (int): neighbor's address (MPI rank ID)
#   rx_params (dict): parameters needed for calculating differences
#       between replicas
# Returns:
#   a boolean "true" or "false" for deciding
#   whether to exchange with this neighborAddress
#   
#---------------------------------------------
proc ::namd::rx::deltaGrid {neighborAddress rx_params} {
    set thisAddress [::myReplica]

    set E_self [::namd::logInfo "MISC"]
    set T      [dict get $rx_params T]
    #----------------------------------------------
    # If the neighborAddress is on the left, do `send`.
    # If the neighborAddress is on the right, do 'receive'.
    # If the neighborAddress is itself, do nothing.
    #----------------------------------------------
    if {$thisAddress > $neighborAddress} {
        ::replicaSend $E_self $neighborAddress
        return {}
    } elseif {$thisAddress < $neighborAddress} {
        set E_other [::replicaRecv $neighborAddress]
        return [list [expr ($E_self - $E_other)/$T]]
    } else {
        # Because the energy difference between one
        # replica and itself is exactly zero.
        # This is true when one replica is compared
        # to itself because it is the first or the last
        # replica.
        return [list 0]
    }
}
