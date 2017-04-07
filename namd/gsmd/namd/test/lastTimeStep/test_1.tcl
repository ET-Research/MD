source "../../config/LastTimeStep-0.1.0.tm"

proc test {xsc_file solution} {
    set answer [::namd::lastTimeStep $xsc_file]
    if {$answer != $solution} {
        puts "test failed!"
    } else {
        puts "pass! $answer == $solution"
    }
}

test "data/restart.xsc" 1000
