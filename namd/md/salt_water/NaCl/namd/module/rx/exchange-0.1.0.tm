namespace eval ::namd::rx {}

#-------------------------------------------------------
# Perform replica exchange
#
# Args:
#   E_self: energy from this replica
#   E_other: energy from the neighboring replica
#   f_compare: name of the function for doing comparison
#       when E_other is higher than E_self (hill climbing)
#       The first argument for f_compare must be dE
#       where dE = E_other - E_self.
#       Other parameters to f_compare can also be supplied
#       after "dE".
#   
#-------------------------------------------------------
proc ::namd::rx::exchange? {E_self E_neighbor f_compare args} {
    set dE [expr $E_other - $E_self]
    return [expr $dE < 0.0 ? true : [$f_compare $dE {*}$args]]
}
