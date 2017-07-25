namespace eval ::namd::rx {}
source module/rx/MetroHast-0.1.0.tm


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
proc ::namd::rx::swap? {algorithm dE params} {
    if {$algorithm eq "MH"} {
        set rxAlgorithm ::namd::rx::MetroHast
        set rxArgs [list [dict get $params T]]
    } else {
        error "(::namd::rx::pipeline) unknown replica exchange algorithm \"$algorithm\""
    }
    return [expr $dE < 0.0 ? true : [$rxAlgorithm $dE {*}$rxArgs]]
}
