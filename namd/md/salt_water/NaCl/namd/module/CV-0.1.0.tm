namespace eval ::namd {namespace export CV}


#------------------------------------------------------------
# Use collective variables
# Args:
# config -- config file name
# input  -- (option) the CV state file from previous run
#------------------------------------------------------------
proc ::namd::CV {params} {
    colvars on
    colvarsConfig [dict get $params config]

    if {[dict exists $params input]} {
        ::colvarsInput [dict get $params input]
    } else {}
}
