namespace eval ::namd::rx {}

#---------------------------------------
# Metropolis-Hastings algorithms
# Args:
#   dE: dE = E_other - E_self
#---------------------------------------
proc ::namd::rx::MetroHast {dE T} {
    set kB 0.0019872041
    set coin_flip [expr rand()]
    if {[expr exp(-$dE/($kB * $T)) > $coin_flip]} {
        return true
    } else {
        return false
    }
}
