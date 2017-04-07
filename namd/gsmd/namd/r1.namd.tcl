source packages.tcl

######################################################
# Author: Yuhang Wang
# License: MIT/X11
# Date:   12/19/2016
######################################################

set stage                1
set pre       [expr $stage - 1]
set isRestart [expr $stage > 1 ? true : false]

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

set restraints [list \
        [dict create \
            ref       "../molecule/backbone.pdb" \
            label     "../molecule/backbone.pdb" \
            scaling   1 \
            column    "B" \
        ] \
    ]

set grid_params [list \
        [dict create \
            label     "../molecule/grid.pdb" \
            dx        "../map/map.dx" \
            pbc       {"yes" "yes" "yes"} \
            scaling   {1 1 1} \
        ] \
    ]

set temperature    310
set save_freq      5000
set em_steps       400
set md_steps       250000

set box_params [dict create \
    size           {161.0 161.0 100.0} \
    center         {0 0 0} \
    isRestart      $isRestart \
]

set force_fields [list \
      ../forcefield/par_all36_prot.prm \
      ../forcefield/par_all36_lipid.prm \
      ../forcefield/par_all36_carb.prm \
      ../forcefield/par_all36_cgenff.prm \
      ../forcefield/toppar_water_ions.str \
    ]

######################################################

exec mkdir -p   "../output/md${stage}"

::namd::io $io_params

::namd::forceField $force_fields

::namd::pbc $box_params

::namd::interaction [dict create \
        cutoff         12. \
    ]

::namd::outputFrequency [dict create \
      dcd      $save_freq \
      restart  $save_freq \
      xst      $save_freq \
      energy   $save_freq \
      pressure $save_freq \
    ]

::namd::integrator [dict create \
        time_step        2.0 \
    ]
    
::namd::pme [dict create spacing 1.0]

::namd::LangevinT [dict create \
        T         $temperature \
        isRestart $isRestart \
    ]

::namd::LangevinP [dict create \
        flexible_cell  "yes" \
        constant_area  "no" \
        constant_ratio "yes" \
        T              $temperature \
    ]


::namd::restrain $restraints  
::namd::gridForce $grid_params

margin 10.

minimize   $em_steps
reinitvels $temperature
run        $md_steps 
