namespace eval ::namd::rx {}

#------------------------------------------------
# Exchange the updated computer addresses between
# two neighbors.
# what's up? === What is your updated address? Here is mine.
#
# Returns:
# Neighbor's updated computer ID (MPI rank)
#------------------------------------------------
proc ::namd::rx::whatsUp {myNewAddress neighborCurrentAddress} {
    return [::replicaSendrecv \
        $myNewAddress \
        $neighborCurrentAddress \
        $neighborCurrentAddress \
    ]
}
