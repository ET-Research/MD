namespace eval ::namd::rx {}
source module/rx/deltaGrid-0.1.0.tm


#-----------------------------------------------
# Compute the difference before and after
#  the replica-exchange attempt.
#-----------------------------------------------
proc ::namd::rx::delta_aux {rx_type rx_params neighborAddress results functions} {
    if {[llength $results] > 0 || [llength $functions] == 0} {
        return [lindex $results 0]
    } else {
        set f [lindex $functions 0]
        set others [lindex $functions 1 end]
        return [::namd::rx::delta_aux \
            $rx_type \
            $rx_params \
            $neighborAddress \
            [$f $rx_type $rx_params $neighborAddress] \
            $others \
        ]
    }
}

proc ::namd::rx::delta {rx_type rx_params neighborAddress} {
    set available [list \
        ::namd::rx::deltaGrid \
    ]
    return [::namd::rx::delta_aux $rx_type $rx_params $neighborAddress {} $available]
}
