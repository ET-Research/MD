namespace eval ::namd {}
source module/tk/convert/list2dict-0.1.0.tm


#-------------------------------
# return a dictionary of NAMD
# log information
#-------------------------------
proc ::namd::logInfo_aux {keys values} {
    upvar 1 NAMD_LOG log
    set log [::namd::tk::convert::list2dict $namd_keys $namd_values]
}
proc ::namd::logInfo {} {

}