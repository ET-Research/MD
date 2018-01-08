namespace eval ::namd::rx {}
source module/rx/updateGrid-0.1.0.tm

# update replica states
# Args:
#   address (int): the current replica address
#   new_state (int): new replica state
#   rx_params (dict): replica-exchange parameters
# -------------------------------------------------------
proc ::namd::rx::update {address new_state rx_params} {
    set rx_type [::dict get $rx_params rx type]
    if {$rx_type eq "grid"} {
        ::namd::rx::updateGrid $address \
            $new_state \
            $rx_params
    } else {
        puts stderr "ERROR: unsupported rx type: $rx_type"
        exit
    }
}