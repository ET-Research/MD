namespace eval ::namd::rx {}
source module/tk/file/file_link-0.1.0.tm

# Update grid for the current replica
# Args:
#   address (int): address of the target replica
#   new_state (int): new state of the target replica
#   grid_files (dict): template names for the "src" and "link" grid files
#   grid_tags (list[str]): a list of tags for the grids
proc ::namd::rx::updateGrid {\
    address \
    new_state \
    grid_files \
    grid_tags} {

    set src_file_name_template [::dict get $grid_files src]
    set local_file_name_template [::dict get $grid_files link]

    set real_file  [format $src_file_name_template $new_state]
    set local_link [format $local_file_name_template $address]

    if {[::file exists $local_link]} {
        # syntax: file delete ?-force? ?--? pathname ?pathname ...?
        # ref: https://wiki.tcl.tk/10058
        # Note: When pathname is a symbolic link, 
        # that symbolic link is removed rather than the file it refers to.
        # This is exactly what I intend to do. So, no problem.
        file delete -- $local_link
        while {[file exists $local_link]} {} ;# wait
    }

    # Create a link to the new grid file
    ::_::file::link -symbolic $local_link $real_file
    while {![file exists $local_link]} {} ;# wait

    foreach tag $grid_tags {
        puts "==== update grid: $tag"
        reloadGridforceGrid $tag
    }
}
