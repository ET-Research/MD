namespace eval ::namd::rx {namespace export exchange}
source module/tk/convert/list2dict-0.1.0.tm

#-------------------------------------------------------
# Perform replica exchange
#-------------------------------------------------------
proc ::namd::rx::exchange {namd_keys namd_values} {
    set log [::namd::tk::convert::list2dict $namd_keys $namd_values]
    set potential [dict get $log POTENTIAL]
    puts "======================================="
    puts "potential = $potential"
    puts "======================================="
}