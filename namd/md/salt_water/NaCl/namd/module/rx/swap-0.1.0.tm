namespace eval ::namd::rx {}
source module/rx/MetroHast-0.1.0.tm
source module/rx/getDeltaEnergy-0.1.0.tm


#---------------------------------------------------
# Decide whether to do a swapping
# Args:
#   dE (double): delta energy
#   f_compare: name of the function for doing comparison
#       when E_other is higher than E_self (hill climbing)
#       The first argument for f_compare must be dE
#       where dE = E_other - E_self.
#       Other parameters to f_compare can also be supplied
#       after "dE".
#   
#---------------------------------------------------
proc ::namd::rx::swap? {neighborAddress p} {
    if {[dict get $p algorithm] eq "MH"} {
        set rxAlgorithm ::namd::rx::MetroHast
        set rxArgs [list [dict get [dict get $p params] T]]
    } else {
        error "(::namd::rx::pipeline) unknown replica exchange algorithm \"$algorithm\""
    }

    if {[dict get $p type] eq "grid"} {
        set energies [::namd::rx::getDeltaEnergy $neighborAddress grid]
    } else {
        set energies [::namd::rx::getDeltaEnergy $neighborAddress potential]
    }

    if {[llength $energies] == 0} {
        return [::replicaRecv $neighborAddress]
    } else {
        lassign $energies E_self E_other
        set dE [expr $E_self - $E_other]
        set decision [expr $dE < 0.0 ? true : [$rxAlgorithm $dE {*}$rxArgs]]
        ::replicaSend $decision $neighborAddress
        return $decision
    }
}
