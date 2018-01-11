namespace eval ::_::file {}


# create a link to a file
# Args:

proc ::_::file::link {link_type link_name target_file} {
  #----------------------------------------
    # note: If linkName already exists, 
    #   or if target doesn't exist, 
    #   an error will be returned.
    # ---------------------------------------
    # file link [-linktype] linkname <target>
    # ---------------------------------------
    # note: On Unix, symbolic links can be made to relative paths, 
    # and those paths must be relative to the actual linkName's 
    # location (not to the cwd), but on all other platforms where 
    # relative links are not supported, target paths will always be 
    # converted to absolute, normalized form before the link is created 
    # (and therefore relative paths are interpreted as relative to the cwd).
    # source: http://wiki.tcl.tk/3482
    #---------
    # Thus it is important to always use absolute path
    puts "== target_file = [file normalize $target_file]"
    puts "== link_file = [file normalize $link_name]"
    ::file link $link_type \
        [::file normalize $link_name] \
        [::file normalize $target_file]
}