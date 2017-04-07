source "../../config/inList-0.1.0.tm"

proc test {x xs solution} {
    set answer [::namd::inList $x $xs]
    if {$answer != $solution} {
        puts "test failed!"
    } else {
        puts "pass! $answer == $solution"
    }
}

test a {a b c} 1
test d {a b c} 0
