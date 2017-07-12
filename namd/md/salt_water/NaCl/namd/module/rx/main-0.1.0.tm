namespace eval ::namd::rx {}
source module/logInfo-0.1.0.tm
source module/rx/pipepline-0.1.0.tm
source module/rx/log-0.1.0.tm 


#------------------------------------------------
# Main execution logic of `rx`.
#
# Args:
#   replicaInfo (dict): replica info dictionary
#   total_steps (int): total number of steps to run
#   block_steps (int): number steps between exchanges
#   T (float): temperature for Metropolis-Hasting algorithm
#   log_file (str): output log file name
#------------------------------------------------
proc ::namd::rx::main \
{ \
    replicaInfo \
    total_steps \
    block_steps \
    T \
    log_file\
} \
{   
    set left  [dict get $replicaInfo L]
    set right [dict get $replicaInfo R]

    ::namd::tk::io::write $log_file ""

    # Total number of exchange attempts
    set N [expr int($total_steps/$block_steps)]

    set ccc 0
    while {$ccc < $N} {
        ::namd::logInfoSetUp
        ::run $block_steps
        ::namd::rx::piepline $ccc $replicaInfo
        ::namd::rx::log $log_file
        incr ccc
    }
}
