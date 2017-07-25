namespace eval ::namd::rx {}

#------------------------------------------
# Exchange replica information
#   between two replicas
# Args:
#   whichNeighbor (str): either "L" or "R"
#   otherNeighbor (str): complement of $whichNeighbor
#   newAddress (int): new computer address to move to (MPI rank ID)
#   replicaInfo (dict): {replica ... L {replica ... address ...} R {replica ... address ...}}
#------------------------------------------
proc ::namd::rx::exchange {whichNeighbor otherNeighbor newAddress replicaInfo} {
    # note: $whichNeighbor will move here
    #   and $otherNeigbor will move to somewhere (need to send a message to ask)
    set here [::myReplica]
    set otherAddress [dict get $replicaInfo $otherNeighbor address]
    set msg $newAddress
    set newReplicaInfo [dict create \
        replica [dict get $replicaInfo replica] \
        $whichNeighbor [dict create \
            replica [dict get $replicaInfo $whichNeighbor replica] \
            address $here \
        ] \
        $otherNeighbor [dict create \
            replica [dict get $replicaInfo $otherNeighbor replica] \
            address [::replicaSendrecv $msg $otherAddress $otherAddress]
        ] \
    ]
    return [::replicaSendrecv $newReplicaInfo $newAddress $newAddress]
}
