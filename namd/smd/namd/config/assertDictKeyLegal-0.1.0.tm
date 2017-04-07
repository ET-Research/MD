namespace eval ::namd { namespace export assertDictKeyLegal }

# assert whether the keys from two dictionaries are equal
proc ::namd::assertDictKeyLegal {default_dict user_dict module_name} {
    set k1 [lsort [dict keys $default_dict]]
    set k2 [lsort [dict keys $user_dict]]

    set illegal_keys [listDiff $k1 $k2]

    if {[llength $illegal_keys] > 0} {
        puts stderr "Error hint: you have specified unknown options for \"$module_name\""
        foreach k $illegal_keys {
            puts stderr "\t $k"
        }
        exit
    }
}
