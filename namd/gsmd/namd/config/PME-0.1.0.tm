namespace eval ::namd {namespace export pme}


#---------------------------------------------------
# Apply PME
# Input dictionary keys
#   spacing - PME grid spacing 
#---------------------------------------------------
proc ::namd::pme {p} {
    PME "yes"
    PMEGridSpacing [dict get $p "spacing"]
}
