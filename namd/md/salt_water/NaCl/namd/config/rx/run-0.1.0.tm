source config/rx/checkReplicaCount-0.1.0.tm

namespace eval ::namd::rx {namespace export run}


#----------------------------------------------------
# NAMD Replica Exchange
#----------------------------------------------------
proc ::namd::rx::run {params} {
    set defaults [dict create \
        total undefined \
    ]
    assertDictKeyLegal $defaults $params "::namd::rx::run"
    set p [dict merge $defaults $params]
    
    replicaBarrier
    ::namd::rx::checkReplicaCount [dict get $p total]
}