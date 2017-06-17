namespace eval ::namd {namespace export GaMD}


#-------------------------------------------------------
# Gaussian accelerated MD
# Args:
# alpha: boost factor. The larger, the less boost.
# E: threshold energy
# alpha_t: alpha for the total potential energy (only available if "dual" is "on")
# E_t: threshold total potential energy (only available if "dual" is "on")
# start: first time step where GaMD starts
# stop (0): last time step where GaMD should stop
#       The default is "0", meaning GaMD will be applied forever.
# freq: the output frequency of GaMD boost potentials
# dihedral (off): if "on", turn on dihedral boost and turn off total boost
#       if "off", turn on total boost and turn off dihedral boost
# dual (off): if "on", then both dihedral and total boost are applied.
# ------------------------------------------------------
proc ::namd::GaMD {params} {
    set defaults [dict create \
        threshold_type 1 \
        prepare         undefined \
    ]

    assertDictKeyLegal $defaults $params "::namd::GMD"
    set p [dict merge $defaults $params]
    
    accelMDG on
    accelMDGiE      [dict get $p threshold_type]
}
