namespace eval ::namd { namespace export listDiff }

# Return  list of items in L2 but not in L1
proc ::namd::listDiff {L1 L2} {
    set diff {}

    foreach k $L2 {
        if {! [inList $k $L1]} {
            lappend diff $k
        }
    }
    
    return $diff
}
