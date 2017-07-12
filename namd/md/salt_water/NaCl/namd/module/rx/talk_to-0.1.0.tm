namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm


#---------------------------------------------
# Let replicas talk to each other
#
# Args:
#   neighbor (int): neighbor's replica ID
#
# Returns:
#   a boolean "true" or "false" for deciding
#   whether to exchange with this neighbor
#---------------------------------------------
proc ::namd::rx::talk_to {neighbor} {
    set E_self [::namd::logInfo POTENTIAL]
    #----------------------------------------------
    # If the neighbor is on the left, do `send`.
    # If the neighbor is on the right, do 'receive'.
    # If the neighbor is itself, do nothing.
    #----------------------------------------------
    if {[myReplica] > $neighbor} {
        ::replicaSend [::namd::logInfo POTENTIAL] $neighbor
        return [::replicaRecv ]
    } elseif {[myReplica] < $neighbor} {
        set E_other [::replicaRecv $neighbor]
    } else {
        set E_other $E_self
    }
    return [list $E_self $E_other]
}
