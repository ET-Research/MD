source module/rx/checkReplicaCount-0.1.0.tm

namespace eval ::namd::rx {namespace export run}

#----------------------------------------------------
# NAMD Replica Exchange
#----------------------------------------------------
proc ::namd::rx::run {params} {
    set defaults [dict create \
        restart undefined \
        steps [dict create \
            total undefined \
            block undefined \
        ] \
        gsmd {} \
    ]

    ::namd::tk::dict::assertDictKeyLegal $defaults $params "::namd::rx::run"
    set p [dict merge $defaults $params]
    
    # total number of MD steps
    set total_steps [dict get $p steps total]

    # number of steps between replica exchanges
    set block_steps [dict get $p steps block]


    ::replicaBarrier
    set rInfo [::namd::rx::replicaNeighbor]
    set ccc 0
    while {$ccc < $total_steps} {
        ::run $block_steps

        incr ccc $block_steps
    }

    ::replicaBarrier
}
