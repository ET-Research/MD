namespace eval ::namd::rx {}

#------------------------------------------------
# Main execution logic of `rx`.
#
# Args:
#   rInfo (dict): replica info dictionary
#   total_steps (int): total number of steps to run
#   block_steps (int): number steps between exchanges
#   T (float): temperature for Metropolis-Hasting algorithm
#   log_file (str): output log file name
#------------------------------------------------
proc ::namd::rx::main {\
    rInfo \
    total_steps \
    block_steps \
    T \
    log_file\
} \
{
    ::namd::tk::io::write $log_file ""

    set ccc 0
    while {$ccc < $total_steps} {
        ::namd::logInfoSetup
        ::run $block_steps

        # ::namd::exchange? [::namd::logInfo POTENTIAL]

        incr ccc $block_steps

        # Save RX log info.
        ::namd::tk::io::appendln \
            $log_file \
            [join \
                [list \
                    $ccc \
                    [myReplica] \
                ] \
                " " \
            ]
    }

}