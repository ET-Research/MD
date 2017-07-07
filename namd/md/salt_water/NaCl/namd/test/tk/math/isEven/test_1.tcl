cd ../../../../
source module/tk/math/isEven-0.1.0.tm


proc test {} {
    if {[string is true [::namd::tk::math::isEven 2]]} {
        puts "Pass!"
    } else {
        puts "Failed!"
    }
}

test