namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm

#--------------------------------------------------------
# Get information of the current replica's neighbor ID's
# and return a dictionary, e.g., {L 0  R 2}
#--------------------------------------------------------
proc ::namd::rx::replicaNeighbors {} {
    if {[::myReplica] == 0} {
        set left 0
    } else {
        set left [expr [::myReplica] - 1]
    }

    if {[::myReplica] == [expr [::numReplicas] - 1]} {
        set right [::myReplica]
    } else {
        set right [expr [::myReplica] + 1]
    }

    return [dict create \
        L $left \
        R $right \
    ]
}
