namespace eval ::namd::tk::io {}

# write string to file without an ending newline
proc ::namd::tk::io::write {file_name content} {
    set OUT [open "$file_name" w]
    puts -nonewline $OUT "$content"
    close $OUT
}
