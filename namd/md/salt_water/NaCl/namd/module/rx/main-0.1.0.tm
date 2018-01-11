namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm
source module/rx/negotiate-0.1.0.tm
source module/rx/rxSaveState-0.1.0.tm 
source module/rx/rxUpdate-0.1.0.tm 


#------------------------------------------------
# Main execution logic of `rx`.
#
# Args:
#   replicaInfo (dict): replica info dictionary
#   total_steps (int): total number of steps to run
#   block_steps (int): number steps between exchanges
#   log_file (str): output log file name
#   rx_specs (dict): replica-exchange parameters
#------------------------------------------------
proc ::namd::rx::main { \
    replicaInfo \
    total_steps \
    block_steps \
    log_file\
    rx_specs \
} {   
    set left  [dict get $replicaInfo L]
    set right [dict get $replicaInfo R]

    ::namd::tk::io::write $log_file ""

    # Total number of exchange attempts
    set N [expr int($total_steps/$block_steps)]

    ::namd::logInfoSetUp
    ::run 0
    set ccc 0

    set thisAddress [::myReplica]
    while {$ccc < $N} {
        if {[llength $replicaInfo] == 0} {
            error ">>>> address $thisAddress:: \
                exchange $ccc, replicaInfo = $replicaInfo"
            exit
        }

        set oldState [::dict get $replicaInfo state]

        # update replicaInfo
        set replicaInfo [::namd::rx::negotiate \
            $ccc $replicaInfo $rx_specs]

        set newState [::dict get $replicaInfo state]
        
        puts "=== address = $thisAddress;\
            after exchange attempt $ccc; \
            replicaInfo = $replicaInfo"  

        if {$newState != $oldState} {
            ::namd::rx::update $thisAddress $newState $rx_specs
        }

        ::namd::rx::saveState $log_file $ccc
        ::run $block_steps
        incr ccc
    }
}
