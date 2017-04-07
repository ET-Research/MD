namespace eval ::namd {namespace export IO}


#----------------------------------------------------
# NAMD input output parameters
# Input dictionary keys (default values)
#   structure (undefined) -- e.g., my.psf
#   coordinates (undefined) -- e.g., my.pdb
#   output_prefix (undefined) -- output file prefix
#   coor (undefined) - *.coor file for restarting
#   vel  (undefined) - *.vel file for restarting
#   xsc  (undefined) - *.xsc file for restarting
#   first_time_step (0) - first time step
#   isRestart (false) - whether this is a restart
proc ::namd::IO {params} {
    set defaults [dict create \
        isRestart      false \
        first_time_step 0 \
        coor            undefined \
        vel             undefined \
        xsc             undefined \
        structure       undefined \
        coordinates     undefined \
        output_prefix   undefined \
    ]

    assertDictKeyLegal $defaults $params "::namd::IO"
    set p [dict merge $defaults $params]
    firsttimestep   [dict get $p first_time_step]
    structure       [dict get $p structure]
    coordinates     [dict get $p coordinates]
    outputname      [dict get $p output_prefix]
    if {[dict get $p "isRestart"] == true} {
        binCoordinates [dict get $p "coor"]
        binVelocities  [dict get $p "vel"]
        extendedSystem [dict get $p "xsc"]
    }
    
}
