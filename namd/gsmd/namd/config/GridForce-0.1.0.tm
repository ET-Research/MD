namespace eval ::namd {namespace export gridForce}


#-------------------------------------------------------
# add grid force
# grid_params: a list of dictionaries with the following keys:
#   label - file name for atom labeling
#   dx - grid dx file name
#   scaling - grid force scaling
#   pbc - flags for using periodic boundary condition
#         along x, y and z
#   scaling_column ("O") - column in pdb file that specifies
#           the scaling factor
#   charge_column ("B") - column in pdb file that specifies
#           the charge
#   volt ("no") - whether to use eV as unit for grid potential
# ------------------------------------------------------
proc ::namd::gridForce {grid_params} {
    set defaults [dict create \
        scaling_column "O" \
        charge_column "B" \
        volt "no" \
    ]
    
    if {[llength $grid_params] > 0} {
        mgridForce on
        set ccc 0
        foreach params $grid_params {
            set p [dict merge $defaults $params]
            incr ccc
            set tag "G${ccc}"
            lassign [dict get $p scaling] sx sy sz
            lassign [dict get $p pbc] pbc_x pbc_y pbc_z

            mgridForceFile      $tag     [dict get $p label]
            mgridForceCol       $tag     O
            mgridForceChargeCol $tag     B
            mgridForceVolts     $tag     [dict get $p volt]
            mgridForcePotFile   $tag     [dict get $p dx]
            mgridForceScale     $tag     $sx $sy $sz
            mgridForceCont1     $tag     $pbc_x
            mgridForceCont2     $tag     $pbc_y
            mgridForceCont3     $tag     $pbc_z
        }
    }
}
