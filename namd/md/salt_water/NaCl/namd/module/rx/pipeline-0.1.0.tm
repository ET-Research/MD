namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/getDeltaEnergy-0.1.0.tm
source module/rx/swap-0.1.0.tm
source module/rx/exchange-0.1.0.tm

# Perform all necessary tasks
# Args:
#   stage (int): which stage of replica-exchange (0-based indexing)
#   replicaInfo (dict): replica info dictionary
#   rx_params (dict): replica exchange parameters
#       algorithm
#       type
proc ::namd::rx::pipeline {stage replicaInfo rx_params} {
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

        set neighborComputerId [dict get $replicaInfo $whichNeighbor computer]

        if {[dict get $rx_params type] eq grid} {
            set dE [::namd::rx::getDeltaEnergy $neighborComputerId grid]
        } else {
            set dE [::namd::rx::getDeltaEnergy $neighborComputerId potential]
        }
       

        set doSwap [::namd::rx::swap? \
            [dict get $rx_params algorithm] \
            $dE \
            [dict get $rx_params params] \
        ]

        if {$doSwap} {
            return [::namd::rx::exchange $whichNeighbor]
        } else {
            return $replicaInfo
        }
}