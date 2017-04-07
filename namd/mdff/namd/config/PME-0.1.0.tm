namespace eval ::namd {namespace export PME}


#---------------------------------------------------
# Apply PME
# Input dictionary keys
#   spacing - PME grid spacing 
#---------------------------------------------------
proc ::namd::PME {params} {
    set defaults [dict create \
        spacing 1.0 \
    ]
    assertDictKeyLegal $defaults $params "::namd::PME"
    set p [dict merge $defaults $params]

    PME yes
    PMEGridSpacing [dict get $p spacing]
}
