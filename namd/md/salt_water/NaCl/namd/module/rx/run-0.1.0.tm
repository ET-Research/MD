namespace eval ::namd::rx {namespace export run}
source module/rx/replicaInfo-0.1.0.tm
source module/rx/main-0.1.0.tm
source module/tk/io/write-0.1.0.tm
source module/tk/io/appendln-0.1.0.tm


#----------------------------------------------------
# NAMD Replica Exchange
#
# Args:
# T (default 298): temperature used for Metropolis-Hasting algorithm
#----------------------------------------------------
proc ::namd::rx::run {params} {
    set defaults [dict create \
        restart undefined \
        steps [dict create \
            total undefined \
            block undefined \
        ] \
        output  undefined \
        grids {} \
        T 300 \
    ]

    ::namd::tk::dict::assertDictKeyLegal $defaults $params "::namd::rx::run"
    set p [dict merge $defaults $params]

    ::replicaBarrier
    ::namd::rx::main \
        [::namd::rx::replicaInfo] \
        [dict get $p steps total] \
        [dict get $p steps block] \
        [dict get $p T] \
        [dict get $p output]
    ::replicaBarrier
}

