proc count {n} {
    set max 10000
    if {$n >= $max} {
        return "reached $max"
    } else {
        tailcall count [expr $n + 1]
    }
}

puts [count 0]