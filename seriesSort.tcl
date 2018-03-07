#! /usr/bin/tclsh

# Set series path
set series(path) "/home/user/Videos/Series"
set series(ext) [list *.mkv *.avi *.mp4]

# Series directory exists?
if {![file isdirectory $series(path)]} {
	puts "Series path doesn't exist."
	exit
}

# Find all series directories that have subdirectories:
set series(found) [glob -nocomplain -type d -directory $series(path) -- /*/*]

# loop through the series folder
foreach dir $series(found) {
	# move all applicable files to the parent directory
	if {[llength [set files [glob -nocomplain -type f -directory $dir -- {*}$series(ext)]]]>0} {
		file rename -force -- {*}$files [join [lrange [split $dir [file separator]] 0 end-1] [file separator]][file separator]
	}
	# Delete the directory
	file delete -force -- $dir[file separator]
}
