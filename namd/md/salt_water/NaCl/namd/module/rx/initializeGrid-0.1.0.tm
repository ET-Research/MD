namespace eval ::namd::rx {}
source module/rx/updateGrid-0.1.0.tm

# create symbolic links to grid files
# Args:
#   rx_specs (dict): rx specifications

proc ::namd::rx::initializeGrid {rx_specs} {
    set thisAddress [::myReplica]
    set thisState [::myReplica]
    set noReload false
    ::namd::rx::updateGrid \
        $thisAddress \
        $thisState \
        [::dict get $rx_specs params] \
        $noReload

    ::namd::gridForce [::dict get $rx_specs params grid_params]
}