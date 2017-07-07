source module/rx/checkReplicaCount-0.1.0.tm

namespace eval ::namd::rx {namespace export run}

#----------------------------------------------------
# NAMD Replica Exchange
#----------------------------------------------------
proc ::namd::rx::run {params} {
    set defaults [dict create \
        total undefined \
        output undefined \
        restart_file undefined \
    ]
    ::namd::tk::dict::assertDictKeyLegal $defaults $params "::namd::rx::run"
    set p [dict merge $defaults $params]
    
    replicaBarrier
    ::namd::rx::checkReplicaCount [dict get $p total]

    set rInfo [::namd::rx::replicaInfo [dict get $p restart_file]]
    puts "==========================="
    puts "replica [myReplica]"
    puts $rInfo
    puts "==========================="
    replicaBarrier
}