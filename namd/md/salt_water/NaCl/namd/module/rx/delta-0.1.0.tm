namespace eval ::namd::rx {}
source module/rx/deltaGrid-0.1.0.tm
source module/rx/deltaFunctionCatalog-0.1.0.tm


#-----------------------------------------------
# Compute the difference before and after
#  the replica-exchange attempt.
#-----------------------------------------------
proc ::namd::rx::delta {rx_type rx_params neighborAddress} {
    set available_functions [::namd::rx::deltaFunctionCatalog]

    if {[::dict exists $available_functions $rx_type]} {
        set f_compute [::dict get $available_functions $rx_type]
        return [$f_compute $rx_params $neighborAddress]
    } else {
        return {}
    }
}
