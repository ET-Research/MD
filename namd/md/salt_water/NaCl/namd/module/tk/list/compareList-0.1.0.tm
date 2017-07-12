namespace eval ::namd::rx::list {}

proc ::namd::rx::compareList {x1 x2} {
    if {[llength $x1] != [$llength $x2]} {
        return false
    } else {
        foreach x $x1 y $x2 {
            if {$x != $y} {
                return false
            }
        }
        return true
    }
}
