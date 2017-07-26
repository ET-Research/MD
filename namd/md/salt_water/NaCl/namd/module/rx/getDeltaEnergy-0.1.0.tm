namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm


#---------------------------------------------
# Get energies from self and neighbors
#   before and after the exchange
#
# Args:
#   neighborAddress (int): neighbor's address (MPI rank ID)
#   energy_term (str): which type of energy (e.g. POTENTIAL)
# Returns:
#   a boolean "true" or "false" for deciding
#   whether to exchange with this neighborAddress
#   
#---------------------------------------------
proc ::namd::rx::getDeltaEnergy {neighborAddress energy_term} {
    if {$energy_term eq "grid"} {
        set term "MISC"
    } else {
        set term [string toupper $energy_term]
    }
    set E_self [::namd::logInfo $term]
    #----------------------------------------------
    # If the neighborAddress is on the left, do `send`.
    # If the neighborAddress is on the right, do 'receive'.
    # If the neighborAddress is itself, do nothing.
    #----------------------------------------------
    if {[::myReplica] > $neighborAddress} {
        ::replicaSend $E_self $neighborAddress
        return {}
    } elseif {[::myReplica] < $neighborAddress} {
        set E_other [::replicaRecv $neighborAddress]
        return [list $E_self $E_other]
    } else {
        return [list $E_self $E_self]
    }
}
