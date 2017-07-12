namespace eval ::namd::tk::dict {}

proc ::namd::tk::dict::isDict {x} {
    return [expr [string is list $x] && ([llength $x % 2] == 0)]
}
