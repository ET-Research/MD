namespace eval ::namd {namespace export restrain}


#----------------------------------------------------------------------
# Restrain atoms with harmonic restraints
# input is dictionary with the following keys:
#   ref - a pdb file with reference positions
#   label - a pdb file with selected atoms labeled
#   column - which column contains the labels
#   scaling - scaling of the restraining forces
#----------------------------------------------------------------------
proc ::namd::restrain {p} {
    foreach item $p {
        constraints on
        consexp   2
        consref   [dict get $item "ref"]
        conskfile [dict get $item "label"]
        conskcol  [dict get $item "column"]
        constraintScaling [dict get $item "scaling"]
    }
}