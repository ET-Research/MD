source module/rx/swap-0.1.0.tm
source module/rx/MetroHast-0.1.0.tm

proc test {} {
    set E_self 0
    set E_other -1
    set T 300
    set answer [::namd::rx::swap? \
        $E_self \
        $E_other \
        ::namd::rx::MetroHast \
        $T \
    ]
    set solution true
    if {$answer == $solution} {
        puts "Pass!"
    } else {
        puts "Failed"
    }
    puts "answer = $answer"
    puts "solution = $solution"
}

test