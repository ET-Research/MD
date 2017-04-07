namespace eval ::namd {namespace export outputFrequency}


#----------------------------------------------------------------------
# Set the output saving frequency
# Input is a dictionary with the following keys:
#   dcd
#   restart
#   xst
#   energy
#   pressure
#----------------------------------------------------------------------
proc ::namd::outputFrequency {p} {
    dcdfreq             [dict get $p "dcd"]
    restartfreq         [dict get $p "restart"]     
    xstFreq             [dict get $p "xst"]
    outputEnergies      [dict get $p "energy"]
    outputPressure      [dict get $p "pressure"]
}