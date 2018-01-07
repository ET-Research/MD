namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/swap-0.1.0.tm
source module/rx/updateReplicaInfo-0.1.0.tm

#------------------------------------------------------------------
# Perform replica exchange core tasks
# Args:
#   stage (int): which stage of replica-exchange (0-based indexing)
#   replicaInfo (dict): replica info dictionary
#   rx_params (dict): replica exchange parameters
#       algorithm
#       type
#------------------------------------------------------------------
proc ::namd::rx::exchange {stage replicaInfo rx_params} {
    #----------------------------------------------------
    # If $stage and [::myReplica] are both even or both odd,
    #   then use talk to the right neighbor.
    # Otherwise, talk to the left neighbor.
    #----------------------------------------------------
    set here [::myReplica]
    if {  [::namd::tk::math::isEven $stage] == \
          [::namd::tk::math::isEven $here] } {
        set activeNeighbor R
        set otherNeighbor L
    } else {
        set activeNeighbor L
        set otherNeighbor R
    }

    puts "=== try to exchange with neighbor: $activeNeighbor"

    if {[llength $replicaInfo] == 0} {
            error ">>>> [::myReplica]:: \
                stage $ccc, replicaInfo = $replicaInfo"
            exit
    }

    puts "====>>> [::myReplica]: \
        stage = $stage replicaInfo = $replicaInfo ===="
    set neighborAddress [dict get $replicaInfo \
        $activeNeighbor address]

    puts ">>> [::myReplica]: do swapping? ==="
    if {[::namd::rx::swap? $neighborAddress $rx_params]} {
        puts "=== Yes, swap!"
        set newAddress $neighborAddress
    } else {
        puts "=== No, no swap :("
        set newAddress $here
    }
    puts ">>> [::myReplica]: stage = $stage, \
        oldAddress= $here \
        newAddress = $newAddress"
    return [::namd::rx::updateReplicaInfo \
        $activeNeighbor \
        $otherNeighbor \
        $newAddress \
        $replicaInfo]
}
