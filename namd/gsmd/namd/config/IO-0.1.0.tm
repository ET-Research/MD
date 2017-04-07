namespace eval ::namd {namespace export io}


#----------------------------------------------------
# NAMD input output parameters
# Input dictionary keys (default values)
#   structure - e.g., my.psf
#   coordinates - e.g., my.pdb
#   output_prefix - output file prefix
#   coor ("") - *.coor file for restarting
#   vel  ("") - *.vel file for restarting
#   xsc  ("") - *.xsc file for restarting
#   first_time_step (0) - first time step
#   isRestart (false) - whether this is a restart
proc ::namd::io {params} {
    set defaults [dict create \
        isRestart false \
        first_time_step 0 \
        coor "" \
        vec "" \
        xsc "" \
    ]

    set p [dict merge $defaults $params]

    firsttimestep   [dict get $p "first_time_step"]
    structure       [dict get $p "structure"]
    coordinates     [dict get $p "coordinates"]
    outputname      [dict get $p "output_prefix"]
    if {[dict get $p "isRestart"] == true} {
        binCoordinates [dict get $p "coor"]
        binVelocities  [dict get $p "vel"]
        extendedSystem [dict get $p "xsc"]
    }
    
}
