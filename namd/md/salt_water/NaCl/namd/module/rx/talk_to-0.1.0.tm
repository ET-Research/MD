namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm

#---------------------------------------------
# Let replicas talk to each other
#
# Args:
#   neighbor (int): neighbor's replica ID
#---------------------------------------------
proc ::namd::rx::talk_to {neighbor} {
    #----------------------------------------------
    # If the neighbor is on the left, do `send`.
    # If the neighbor is on the right, do 'receive'.
    # If the neighbor is itself, do nothing.
    #----------------------------------------------
    puts "-----------------------"
    puts "self: [myReplica]"
    puts "neighbor: $neighbor"
    puts "-----------------------"
    if {[myReplica] > $neighbor} {
        ::replicaSend [::namd::logInfo POTENTIAL] $neighbor
    } elseif {[myReplica] < $neighbor} {
        set E_other [::replicaRecv $neighbor]
    } else {
        return 
    }
}