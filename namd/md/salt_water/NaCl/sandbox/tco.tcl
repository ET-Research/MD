proc count {n} {
    set max 1000000
    if {$n >= $max} {
        return "reached $max"
    } else {
        tailcall count [expr $n + 1]
    }
}

puts [count 0]