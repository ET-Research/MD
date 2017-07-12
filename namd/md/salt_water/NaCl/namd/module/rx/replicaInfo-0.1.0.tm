namespace eval ::namd::rx {}

#--------------------------------------------------------
# Get information of the current replica
# and return a dictionary.
#--------------------------------------------------------
proc ::namd::rx::replicaInfo {} {
    set here   [::myReplica]
    set lower  [expr $here - 1]
    set higher [expr $here + 1]

    if {[expr [::myReplica] + 1] < [::numReplicas]} {
        set right $higher
    } else {
        set right $here
    }

    if {[::myReplica] > 0} {
        set left $lower
    } else {
        set left $here
    }

    return [dict create \
        replica $here \
        L [dict create \
            replica $left \
            address $left \
          ] \
        R [dict create \
            replica  $right \
            address $right \
          ] \
    ]
}
