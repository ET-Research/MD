set a 0
proc newSet {var_name} {
    upvar 1 $var_name x
    set x 1001
}

newSet a

puts "a = $a"