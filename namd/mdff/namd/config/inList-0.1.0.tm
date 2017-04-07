namespace eval ::namd { namespace export inList }

proc ::namd::inList {x L} {
    foreach y $L {
        if {$x == $y} {
            return 1
        }
    }
    return 0
}
