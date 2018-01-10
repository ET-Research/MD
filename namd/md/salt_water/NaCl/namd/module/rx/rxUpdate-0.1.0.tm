namespace eval ::namd::rx {}
source module/rx/updateGrid-0.1.0.tm

# update replica states
# Args:
#   address (int): the current replica address
#   new_state (int): new replica state
#   rx_specs (dict): replica-exchange parameters
# -------------------------------------------------------
proc ::namd::rx::update {address new_state rx_specs} {
    set rx_variable [::dict get $rx_specs variable]
    if {$rx_variable eq "grid"} {
        ::namd::rx::updateGrid \
            $address \
            $new_state \
            [::dict get $rx_specs params grid_files]
    } else {
        puts stderr "ERROR: unsupported rx reaction coordinate: $rx_variable"
        exit
    }
}