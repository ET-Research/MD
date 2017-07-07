namespace eval ::namd {namespace export forceField}


#------------------------------------------------------------
# Force field parameters
# Args:
#   ff_list - a list of force field file names
#------------------------------------------------------------
proc ::namd::forceField {ff_list} {
    paraTypeCharmm on
    foreach ff $ff_list {
      parameters $ff
    }
}