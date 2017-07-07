source module/tk/convert/list2dict-0.1.0.tm
source module/tk/list/assertEqual-0.1.0.tm

proc test {} {
    set answer [::namd::tk::convert::list2dict {k1 k2} {v1 v2}]
    set solution {k1 v1 k2 v3}
    if {![::namd::tk::list::assertEqual $answer $solution]} {
        puts "Pass!"
    } else {
        puts "Failed!"
    }
}

test