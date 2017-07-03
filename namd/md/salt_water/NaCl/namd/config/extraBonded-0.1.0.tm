namespace eval ::namd { namespace export extraBonded }

#-------------------------------------------------------
# Add additional bonded interactions
# files: a list of files with extra bonded interaction definitions
# ------------------------------------------------------
proc ::namd::extraBonded {files} {
    extraBonds on
    foreach f $files {
        extraBondsFile $f
    }
}
