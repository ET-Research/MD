namespace eval ::namd {}

#---------------------------------------
# Metropolis-Hastings algorithms
# Args:
#   dE: dE = E_other - E_self
#---------------------------------------
proc ::namd::MetroHast {dE T} {
    set kB 0.0019872041
    return [expr exp(-$dE/($kB * $T))]
}
