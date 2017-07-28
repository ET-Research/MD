namespace eval ::namd::rx {}

#---------------------------------------
# Metropolis-Hastings algorithms
# Args:
#   dE: dE = E_other - E_self
#---------------------------------------
proc ::namd::rx::MetroHast {dE_over_T} {
    set kB [expr 0.0019872041] ;# kcal/mol/K
    if {$dE_over_T < 0} {
        return true
    } else {
        set coin_flip [expr rand()]
        if {[expr exp(-$dE_over_T/(${kB})) > $coin_flip]} {
            return true
        } else {
            return false
        }
    }
}
