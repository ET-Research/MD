namespace eval ::namd::rx {}
source module/tk/math/isEven-0.1.0.tm
source module/rx/talk_to-0.1.0.tm
source module/rx/exchange-0.1.0.tm
source module/rx/MetroHast-0.1.0.tm

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
proc ::namd::rx::main {\
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
        ::namd::logInfoSetup
        ::run $block_steps

        #----------------------------------------------------
        # If $ccc and [::myReplica] are both even or both odd,
        #   then use talk to the right neighbor.
        # Otherwise, talk to the left neighbor.
        #----------------------------------------------------
        if {  [::namd::tk::math::isEven $ccc] == \
              [::namd::tk::math::isEven [::myReplica]] } {
            set whichNeighbor R
        } else {
            set whichNeighbor L
        }

        # get potential energies
        lassign [::namd::rx::talk_to \
                    [dict get $replicaInfo $whichNeighbor] \
                ] \
                E_self \
                E_other

        [::namd::rx::exchange? $E_self $E_other ::namd::rx::MetroHast $T]

        #------------------------------
        # Save RX log info.
        #------------------------------
        ::namd::tk::io::appendln \
            $log_file \
            [join \
                [list \
                    [expr $ccc + 1] \
                    [::myReplica] \
                ] \
                " " \
            ]
        #-------------------------
        incr ccc
        #-------------------------
    }
}
