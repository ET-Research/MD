namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/getDeltaEnergy-0.1.0.tm
source module/rx/swap-0.1.0.tm
source module/rx/exchange-0.1.0.tm

#------------------------------------------------------------------
# Perform all necessary tasks
# Args:
#   stage (int): which stage of replica-exchange (0-based indexing)
#   replicaInfo (dict): replica info dictionary
#   rx_params (dict): replica exchange parameters
#       algorithm
#       type
#------------------------------------------------------------------
proc ::namd::rx::pipeline {stage replicaInfo rx_params} {
    #----------------------------------------------------
    # If $stage and [::myReplica] are both even or both odd,
    #   then use talk to the right neighbor.
    # Otherwise, talk to the left neighbor.
    #----------------------------------------------------
    if {  [::namd::tk::math::isEven $stage] == \
          [::namd::tk::math::isEven [::myReplica]] } {
        set whichNeighbor R
        set otherNeighbor L
    } else {
        set whichNeighbor L
        set otherNeighbor R
    }

    set neighborAddress [dict get $replicaInfo $whichNeighbor address]

    if {[dict get $rx_params type] eq grid} {
        set dE [::namd::rx::getDeltaEnergy $neighborAddress grid]
    } else {
        set dE [::namd::rx::getDeltaEnergy $neighborAddress potential]
    }
   

    set doSwap [::namd::rx::swap? \
        [dict get $rx_params algorithm] \
        $dE \
        [dict get $rx_params params] \
    ]

    if {$doSwap} {
        set newAddress $neighborAddress
        return [::namd::rx::exchange \
            $whichNeighbor $otherNeighbor $newAddress $replicaInfo]
    } else {
        set newAddress [::myReplica]
        set otherAddress [dict get $replicaInfo $otherNeighbor address]
        set msg $newAddress
        return [dict merge \
            $replicaInfo \
            [dict create \
                $otherNeighbor [dict create \
                    replica [dict get $replicaInfo $otherNeighbor replica] \
                    address [::replicaSendrecv $msg $otherAddress $otherAddress] \
                ] \
            ] \
        ]
    }
}
