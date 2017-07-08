namespace eval ::namd::tk::io {}

# write string to file with an ending newline
proc ::namd::tk::io::appendln {file_name content} {
    set OUT [open "$file_name" a]
    puts $OUT "$content"
    close $OUT
}
