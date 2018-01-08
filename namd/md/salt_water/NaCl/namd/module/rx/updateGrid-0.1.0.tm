namespace eval ::namd::rx {}

proc ::namd::rx::updateGrid {\
    address \
    new_state \
    rx_params} {

    set src_file_name_template [::dict get $rx_params
        template src]
    set real_file [format $src_file_name_template $address]
    set local_link_file [format $local_file_name_template $new_state]
    file delete $local_link_file
    while {[file exists $local_link_file]} {} ;# wait

    # note: If linkName already exists, 
    #   or if target doesn't exist, 
    #   an error will be returned.
    # ---------------------------------------
    # file link [-linktype] linkname <target>
    # ---------------------------------------
    file link -symbolic $local_link_file $real_file

    while {![file exists $local_link_file]} {} ;# wait
    reloadGridforceGrid 0
}
