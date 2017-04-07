source "../../config/inList-0.1.0.tm"
source "../../config/listDiff-0.1.0.tm"

proc test {ls1 ls2 solution} {
    set answer [::namd::listDiff $ls1 $ls2]
    if {[llength $solution] != [llength $answer]} {
        puts stderr "Error hint: answer has different length than the solution"
        exit
    }
    for {set i 0} {$i < [llength $solution]} {incr i} {
        set x [lindex $answer $i]
        set y [lindex $solution $i]
        if {$x != $y} {
            puts stderr "item $i not equal: $x != $y"
            exit
        }
    }
    puts "pass!"
}

test {a b c} {a b} {}
test {a b c} {a b d} {d}
test {a b c} {d e} {d e}
