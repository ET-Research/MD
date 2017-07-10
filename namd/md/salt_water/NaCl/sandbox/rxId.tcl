proc replicaInfo {r nr} {
  set replica(index) $r
  set replica(loc.a) $r
  set replica(index.a) $r
  set replica(loc.b) $r
  set replica(index.b) $r

  if { $r % 2 == 0 && $r+1 < $nr } {
    set replica(loc.a) [expr $r+1]
    set replica(index.a) [expr $r+1]
  }
  if { $r % 2 == 1 && $r > 0 } {
    set replica(loc.a) [expr $r-1]
    set replica(index.a) [expr $r-1]
  }

  if { $r % 2 == 1 && $r+1 < $nr } {
    set replica(loc.b) [expr $r+1]
    set replica(index.b) [expr $r+1]
  }
  if { $r % 2 == 0 && $r > 0 } {
    set replica(loc.b) [expr $r-1]
    set replica(index.b) [expr $r-1]
  }

  return [array get replica]

}


proc main {argv} {
  set id [lindex $argv 0]
  set nr [lindex $argv 1]
  set info [replicaInfo $id $nr]
  foreach k [lsort [dict keys $info]] {
    puts "$k: [dict get $info $k]"
  }
}

main $argv
exit