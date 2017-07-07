cd ../../../../
source module/tk/math/isEven-0.1.0.tm

proc test {} {
    if {[string is false [::namd::tk::math::isEven 1]]} {
        puts "Pass!"
    } else {
        puts "Failed!"
    }
}

test