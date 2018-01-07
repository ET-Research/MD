namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm
source module/rx/exchange-0.1.0.tm
source module/rx/log-0.1.0.tm 


#------------------------------------------------
# Main execution logic of `rx`.
#
# Args:
#   replicaInfo (dict): replica info dictionary
#   total_steps (int): total number of steps to run
#   block_steps (int): number steps between exchanges
#   log_file (str): output log file name
#   rx_params (dict): replica-exchange parameters
#------------------------------------------------
proc ::namd::rx::main { \
    replicaInfo \
    total_steps \
    block_steps \
    log_file\
    rx_params \
} {   
    set left  [dict get $replicaInfo L]
    set right [dict get $replicaInfo R]

    ::namd::tk::io::write $log_file ""

    # Total number of exchange attempts
    set N [expr int($total_steps/$block_steps)]

    ::namd::logInfoSetUp
    ::run 0
    set ccc 0
    while {$ccc < $N} {
        if {[llength $replicaInfo] == 0} {
            error ">>>> [::myReplica]:: \
                stage $ccc, replicaInfo = $replicaInfo"
            exit
        }

        set replicaInfo [::namd::rx::exchange \
            $ccc $replicaInfo $rx_params]
            
        ::namd::rx::log $log_file $ccc
        ::run $block_steps
        incr ccc
    }
}
