namespace eval ::namd::rx {}

# Write replica-exchange log file
proc ::namd::rx::saveState {log_file_name ccc} {
    ::namd::tk::io::appendln \
        $log_file_name \
        [join \
            [list \
                [expr $ccc + 1] \
                [::myReplica] \
            ] \
            " " \
        ]
}