namespace eval ::namd::rx {}
source module/rx/MetroHast-0.1.0.tm
source module/rx/getEnergies-0.1.0.tm


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
proc ::namd::rx::swap? {neighborAddress rx_params} {
    if {[dict get $rx_params algorithm] eq "MH"} {
        set rxAlgorithm ::namd::rx::MetroHast
        set rxArgs [list [dict get [dict get $rx_params params] T]]
    } else {
        error "(::namd::rx::pipeline) unknown replica exchange algorithm \"$algorithm\""
    }

    if {[dict get $rx_params type] eq "grid"} {
        set energies [::namd::rx::getEnergies $neighborAddress grid]
    } else {
        set energies [::namd::rx::getEnergies $neighborAddress potential]
    }

    if {[::numReplicas] == 1} {
        return false
    } elseif {[llength $energies] == 2} {
        lassign $energies E_self E_other
        set decision [$rxAlgorithm $E_self $E_other $rx_params]
        ::replicaSend $decision $neighborAddress
        return $decision
    } else {
        return [::replicaRecv $neighborAddress]
    }
}
