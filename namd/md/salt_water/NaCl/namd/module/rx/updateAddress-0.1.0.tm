namespace eval ::namd::rx {}
source module/rx/whatsUp-0.1.0.tm

#-------------------------------------------------------
# Perform replica exchange
#
# Args:
# whichNeighbor: which neighbor to move to.
#
# note:
# The current neighbor will move to this computer
# Also need to ask the other neighbor where it is going
# to move.
#-------------------------------------------------------
proc ::namd::rx::updateAddress {relocate whichNeighbor replicaInfo} {
    # note: nextNeighbor is the neighbor that will be active
    # during next round of replica-exchange attempt.
    if {$whichNeighbor eq L} {
        set currentNeighbor L
        set nextNeighbor    R
    } else {
        set currentNeighbor R
        set nextNeighbor    L
    }

    set thisAddress [::myReplica]
    set nextNeighborCurrentAddress [dict get $replicaInfo $nextNeighbor address]
    
    if {$relocate} {
        set myNewAddress  [dict get $replicaInfo $currentNeighbor address]
    } else {
        set myNewAddress  $thisAddress
    }

    return [dict create \
        [dict get $replicaInfo replica] \
        $currentNeighbor [dict create \
            replica  [dict get $replicaInfo $currentNeighbor replica] \
            address  $thisAddress
        ] \
        $nextNeighbor [dict create \
            replica  [dict get $replicaInfo $nextNeighbor replica] \
            address  [::namd::rx::whatsUp $myNewAddress $nextNeighborCurrentAddress] \
        ] \
    ]
}
