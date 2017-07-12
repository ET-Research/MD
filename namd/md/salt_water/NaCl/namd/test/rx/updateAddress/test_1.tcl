source module/rx/updateAddress-0.1.0.tm

# a stub
proc ::namd::rx::whatsUp {myNewAddress neighorCurrentAddress} {
    return 2
}

proc ::myReplica {} {
    return 1
}

proc test {} {
    set relocate true
    set replicaInfo {
        replica 1
        L {
            replica 0
            address 0
        }
        R {
            replica 2
            address 2
        }
    }
    set whichNeighbor L

    set answer [::namd::rx::updateAddress ${relocate} $whichNeighbor $replicaInfo ]

    if {$answer == $solution} {
        puts "Pass!"
    } else {
        puts "Failed"
    }
    puts "answer = $answer"
    puts "solution = $solution"
}

test