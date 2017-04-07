source packages.tcl

######################################################
# Author: Steven(Yuhang) Wang
# License: CC BY 4.0 (creativecommons.org/licenses/by/4.0)
# Date:   02/24/2017
######################################################

set stage     1
set pre       [expr $stage - 1]
set isRestart [expr $stage > 1 ? true : false]

set temperature    310
set save_freq      200
set em_steps       500
set md_steps       1000

set io_params [dict create \
        first_time_step 0 \
        structure       "../molecule/system.psf" \
        coordinates     "../molecule/system.pdb" \
        output_prefix   "../output/md${stage}/md${stage}" \
        coor            "../output/md${pre}/md${pre}.restart.coor" \
        vel             "../output/md${pre}/md${pre}.restart.vel" \
        xsc             "../output/md${pre}/md${pre}.restart.xsc" \
        isRestart       $isRestart \
    ]

set symmetryParams [dict create \
  matrix "../restraint/mdff_symmetry_matrices.txt" \
  label  "../restraint/mdff_symmetry_labels.pdb" \
  k      "../restraint/mdff_symmetry_k.pdb" \
]

set extraBondedParams [list \
  "../restraint/chirality.txt" \
  "../restraint/ss.txt" \
]

set grid_params [list \
        [dict create \
            label     "../restraint/mdff_customer_labels.pdb" \
            dx        "../map/mdff_grid.dx" \
            pbc       {no no no} \
            scaling   {0.3 0.3 0.3} \
        ] \
    ]

set force_fields [list \
      ../forcefield/par_all36_prot.prm \
      ../forcefield/par_all36_lipid.prm \
      ../forcefield/par_all36_carb.prm \
      ../forcefield/par_all36_cgenff.prm \
      ../forcefield/toppar_all36_prot_arg0.str \
      ../forcefield/toppar_water_ions.str \
    ]

######################################################

exec mkdir -p   "../output/md${stage}"

::namd::IO $io_params

::namd::forceField $force_fields

::namd::GB [dict create \
        ion_molar   0.150 \
        born_cutoff 14.0 \
    ] 

::namd::interaction [dict create \
        switch_dist    15.0 \
        cutoff         16.0 \
        pair_list_dist 17.0 \
    ]

::namd::outputFrequency [dict create \
      dcd      $save_freq \
      restart  $save_freq \
      xst      $save_freq \
      energy   $save_freq \
      pressure $save_freq \
    ]

::namd::integrator [dict create \
        time_step        1.0 \
        nonbonded_freq   2 \
        elec_freq        4 \
    ]
    

::namd::LangevinT [dict create \
        T         $temperature \
        isRestart $isRestart \
    ]

::namd::gridForce $grid_params

::namd::extraBonded $extraBondedParams

::namd::symmetryRestraint $symmetryParams

minimize   $em_steps
reinitvels $temperature
run        $md_steps 
