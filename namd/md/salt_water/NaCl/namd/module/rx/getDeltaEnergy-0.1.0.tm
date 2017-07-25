namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm


#---------------------------------------------
# Get energies from self and neighbors
#   before and after the exchange
#
# Args:
#   neighbor (int): neighbor's computer ID (MPI rank)
#   energy_term (str): which type of energy (e.g. POTENTIAL)
# Returns:
#   a boolean "true" or "false" for deciding
#   whether to exchange with this neighbor
#   
#---------------------------------------------
proc ::namd::rx::getEnergy {neighbor energy_term} {
    set E_self [::namd::logInfo [string toupper $energy_term]]
    #----------------------------------------------
    # If the neighbor is on the left, do `send`.
    # If the neighbor is on the right, do 'receive'.
    # If the neighbor is itself, do nothing.
    #----------------------------------------------
    if {[myReplica] > $neighbor} {
        ::replicaSend [::namd::logInfo $energy_term] $neighbor
        return [::replicaRecv ]
    } elseif {[myReplica] < $neighbor} {
        set E_other [::replicaRecv $neighbor]
    } else {
        set E_other $E_self
    }
    return [list $E_self $E_other]
}
