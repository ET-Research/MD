namespace eval ::namd {}


#------------------------------------------------------------
# Collective variables
# parameters:
# vector - electrostatic field vector, e.g., {0 0 -2.31}
# normalized - "yes" | "no"
#------------------------------------------------------------
proc ::namd::elecField {d} {
    eFieldOn              yes
    eField                [dict get $d vector]
    eFieldNormalized      [dict get $d normalized]
}