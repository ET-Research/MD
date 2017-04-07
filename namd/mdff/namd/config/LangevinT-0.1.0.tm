namespace eval ::namd {namespace export LangevinT}


#---------------------------------------------------
# Apply Langevin temperature control
# input dictionary keys (default values):
#   T (310) -- temperature
#   isRestart (false) -- "true"/"false"
#   couple_H (off) -- whether to include hydrogens to the bath
#   damping (5) -- Langevin damping coefficient
#---------------------------------------------------
proc ::namd::LangevinT {params} {
    set defaults [dict create \
        damping 5 \
        couple_H off \
        isRestart false \
        T 310 \
    ]
    
    assertDictKeyLegal $defaults $params "::namd::LangevinT"
    set p [dict merge $defaults $params]

    if {[dict get $p "isRestart"] == false} {
        temperature [dict get $p "T"]
    } else {}
    
    langevin            on              
    langevinTemp        [dict get $p "T"]
    langevinDamping     [dict get $p "damping"]
    langevinHydrogen    [dict get $p "couple_H"]
}
