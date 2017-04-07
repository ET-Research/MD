namespace eval ::namd {namespace export interaction}


#---------------------------------------------------
# Interaction parameters
# Input dictionary keys (default values):
#   exclude ("scaled1-4") - CHARMM 1-4 bounded interaction exclusion
#   1-4_scaling (1.0) - 1-4 bounded atom interaction scaling
#   cutoff (12.0) - cutoff for all non-bonded interactions
#   switching ("on") - using switching scheme
#   switch_dist (10.) - distance where switching starts
#   pair_list_dist (13.5) - cutoff for pair-wise nonbonded interactions
#---------------------------------------------------
proc ::namd::interaction {params} {
    set defaults [dict create \
        exclude       "scaled1-4" \
        1-4_scaling    1.0 \
        switch_dist    10.0 \
        cutoff         12.0 \
        switching      on \
        pair_list_dist 13.5 \
    ]
    
    assertDictKeyLegal $defaults $params "::namd::interaction"
    set p [dict merge $defaults $params]

    exclude             [dict get $p exclude]
    1-4scaling          [dict get $p 1-4_scaling]
    cutoff              [dict get $p cutoff]
    switching           [dict get $p switching]
    switchdist          [dict get $p switch_dist]
    pairlistdist        [dict get $p pair_list_dist]
}
