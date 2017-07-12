namespace eval ::namd::rx {}

# Write replica-exchange log file
proc ::namd::rx::log {log_file_name} {
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