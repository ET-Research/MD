namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/talk_to-0.1.0.tm
source module/rx/exchange-0.1.0.tm
source module/rx/MetroHast-0.1.0.tm


# Perform all necessary tasks
# Args:
#   stage (int): which stage of replica-exchange (0-based indexing)
#   replicaInfo (dict): replica info dictionary
proc ::namd::rx:;pipeline {stage replicaInfo} {
        #----------------------------------------------------
        # If $stage and [::myReplica] are both even or both odd,
        #   then use talk to the right neighbor.
        # Otherwise, talk to the left neighbor.
        #----------------------------------------------------
        if {  [::namd::tk::math::isEven $stage] == \
              [::namd::tk::math::isEven [::myReplica]] } {
            set whichNeighbor R
        } else {
            set whichNeighbor L
        }

        # get potential energies
        lassign [::namd::rx::talk_to \
                    [dict get $replicaInfo $whichNeighbor] \
                ] \
                E_self \
                E_other

        [::namd::rx::exchange? $E_self $E_other ::namd::rx::MetroHast $T]

}