namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/swap-0.1.0.tm
source module/rx/updateReplicaInfo-0.1.0.tm

#------------------------------------------------------------------
# Perform replica exchange core tasks: negotiate for relocation
# Key idea: the order of states stay the same throughout the simulation.
#   Only the addresses of these states change from time to time.
# Args:
#   stage (int): which stage of replica-exchange (0-based indexing)
#   replicaInfo (dict): replica info dictionary
#   rx_params (dict): replica exchange parameters
#       algorithm
#       type
#------------------------------------------------------------------
proc ::namd::rx::negotiate {stage replicaInfo rx_params} {
    #----------------------------------------------------
    # If the exchange stage and the state are both even or both odd,
    #   then use talk to the right neighbor.
    # Otherwise, talk to the left neighbor.
    #----------------------------------------------------
    set thisAddress [::myReplica]
    set currentState [::dict get $replicaInfo state]

    if {[::namd::tk::math::isEven $stage] == \
        [::namd::tk::math::isEven $currentState]} {
        set activeNeighbor R
        set otherNeighbor L
    } else {
        set activeNeighbor L
        set otherNeighbor R
    }

    puts "=== try to exchange with neighbor: $activeNeighbor"

    if {[llength $replicaInfo] == 0} {
            error ">>>> ERROR: replicaInfo became empty for \
                address $thisAddress \
                exchange $ccc \
                replicaInfo = $replicaInfo"
            exit
    }

    puts "====>>>\
        stage = $stage \
        state = $currentState \
        replicaInfo = $replicaInfo"

    set activeNeighborAddress [dict get $replicaInfo \
        $activeNeighbor address]

    puts ">>> address $thisAddress: do swapping?"
    if {[::namd::rx::swap? $activeNeighborAddress $rx_params]} {
        puts "=== Yes, swap!"
        set newAddress $activeNeighborAddress
    } else {
        puts "=== No, no swap :("
        set newAddress $thisAddress
    }

    puts ">>> address = $thisAddress \
        oldAddress= $thisAddress \
        newAddress = $newAddress"

    return [::namd::rx::updateReplicaInfo \
        $activeNeighbor \
        $otherNeighbor \
        $newAddress \
        $replicaInfo]
}
