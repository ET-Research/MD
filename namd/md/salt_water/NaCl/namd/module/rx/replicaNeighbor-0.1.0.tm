source module/tk/math/isEven-0.1.0.tm

namespace eval ::namd::rx {namespace export replicaNeighbor}

#--------------------------------------------------------
# Get information of the current replica
# and return a dictionary.
#--------------------------------------------------------
proc ::namd::rx::replicaNeighbor {} {
    set here  [::myReplica]
    set left  [expr $here - 1]
    set right [expr $here + 1]

    if {[::namd::tk::math::isEven [::myReplica]]} {
        if {[expr [::myReplica] + 1] < [::numReplicas]} {
            set local_a $right
            set index_a $right
        } else {
            set local_a $here
            set index_a $here
        }

        if {[::myReplica] > 0} {
            set local_b $left
            set index_b $left
        } else {
            set local_b $here
            set index_b $here
        }
    } else {
        if {[::myReplica] > 0} {
            set local_a $left
            set index_a $left
        } else {
            set local_a $here
            set index_a $here
        }

        if {[expr [::myReplica] + 1] < [::numReplicas]} {
            set local_b $right
            set index_b $right
        } else {
            set local_b $here
            set index_b $here
        }
    }

    return [dict create \
        id [::myReplica] \
        a [dict create \
            local $local_a \
            index $index_a \
        ] \
        b [dict create \
            local $local_b \
            index $index_b \
        ] \
    ]
}
