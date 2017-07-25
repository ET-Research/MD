source module/tk/list/assertEqual-0.1.0.tm

proc test {} {
    set a1 {1 2}
    set a2 {1 2}
    set answer [::namd::tk::list::assertEqual $a1 $a2]
    set solution true
    if {$answer == $solution} {
        puts "pass!"
    } else {
        puts "fail!"
    }
}
test