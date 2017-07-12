namespace eval ::namd::tk::dict {}

proc ::namd::tk::dict::compareDict {d1 d2} {
    set keys1 [dict keys $d1]
    set keys2 [dict keys $d2]
    if {[llength $keys1] != [llength $keys2]} {
        return false
    } else {
        foreach k $keys1 {
            
        }
    }
}