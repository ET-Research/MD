namespace eval ::namd::rx {}
source module/rx/MetroHast-0.1.0.tm
source module/rx/delta-0.1.0.tm


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
proc ::namd::rx::swap? {neighborAddress rx_config} {
    if {[::numReplicas] == 1} {
        return false
    }

    set availableAlgo [dict create \
        MH ::namd::rx::MetroHast \
    ]

    set algorithm [dict get $rx_config algorithm]
    if {[dict exists $availableAlgo $algorithm]} {
        set rxAlgorithm [dict get $availableAlgo $algorithm]
    } else {
        error "(from ::namd::rx::swap?) unknown replica exchange algorithm \"$algorithm\""
    }

    set diff [::namd::rx::delta \
        [dict get $rx_config type] \
        [dict get $rx_config params] \
        $neighborAddress \
    ]

    if {[llength $diff] > 0} {
        set dE_over_T [lindex $diff 0]
        set decision [$rxAlgorithm $dE_over_T]
        # send swapping decision to its neighbor
        ::replicaSend $decision $neighborAddress
        return $decision
    } else {
        # get swapping decision from its neighbor
        return [::replicaRecv $neighborAddress]
    }
}
