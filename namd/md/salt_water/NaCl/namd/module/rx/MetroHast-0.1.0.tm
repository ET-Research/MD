namespace eval ::namd::rx {}

#---------------------------------------
# Metropolis-Hastings algorithms
# Args:
#   dE: dE = E_other - E_self
#---------------------------------------
proc ::namd::rx::MetroHast {E_self E_other rx_params} {
    set kB [expr 0.0019872041]
    set dE [expr $E_self - $E_other]
    if {$dE < 0} {
        return true
    } else {
        set coin_flip [expr rand()]
        if {[expr exp(-$dE/(${kB} * $T)) > $coin_flip]} {
            return true
        } else {
            return false
        }
    }
}
