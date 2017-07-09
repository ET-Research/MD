namespace eval ::namd::rx {}


#-------------------------------------------------------
# Perform replica exchange
#-------------------------------------------------------
proc ::namd::rx::exchange? {namd_keys namd_values} {
    set log [::namd::tk::convert::list2dict $namd_keys $namd_values]
    set E [dict get $log POTENTIAL]
    puts "======================================="
    puts "potential = $E"
    puts "======================================="
    return "hello world!"

}