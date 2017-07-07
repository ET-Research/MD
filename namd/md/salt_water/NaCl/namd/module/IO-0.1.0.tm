namespace eval ::namd {namespace export IO}


#----------------------------------------------------
# NAMD input output parameters
# Input dictionary keys (default values)
#   structure (undefined) -- e.g., my.psf
#   coordinates (undefined) -- e.g., my.pdb
#   output_prefix (undefined) -- output file prefix
#   input_prefix (undefined) -- input file prefix
#   first_time_step (0) - (optional) first time step
#       only used when "isRestart" is "true".
#   isRestart (false) - whether this is a restart
#----------------------------------------------------
proc ::namd::IO {params} {
    set defaults [dict create \
        isRestart       false \
        first_time_step undefined \
        structure       undefined \
        coordinates     undefined \
        output_prefix   undefined \
        input_prefix    undefined \
    ]

    ::namd::tk::dict::assertDictKeyLegal $defaults $params "::namd::IO"
    set p [dict merge $defaults $params]
    set input_prefix [dict get $p input_prefix]
    
    if {[string is true [dict get $p isRestart]]} {
        if {![string equal [dict get $p first_time_step] undefined]} {
            firsttimestep   [dict get $p first_time_step]
        } else {
            firsttimestep   [::namd::lastTimeStep "${input_prefix}.xsc"]
        }
    }

    structure       [dict get $p structure]
    coordinates     [dict get $p coordinates]
    outputname      [dict get $p output_prefix]
    if {[dict get $p "isRestart"] == true} {
        binCoordinates   "${input_prefix}.coor"
        binVelocities    "${input_prefix}.vel"
        extendedSystem   "${input_prefix}.xsc"
    }
}
