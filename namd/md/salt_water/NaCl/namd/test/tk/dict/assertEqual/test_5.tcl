source module/tk/dict/assertEqual-0.1.0.tm

proc test {} {
    set a1 {a
        {b {1 2}}
    }
    set a2 {a
        {b {1 2 3}}
    }
    set answer [::namd::tk::dict::assertEqual $a1 $a2]
    set solution false
    if {$answer == $solution} {
        puts "pass!"
    } else {
        puts "fail!"
    }
}
test