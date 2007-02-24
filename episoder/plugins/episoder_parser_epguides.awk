# episoder epguides.com parser
#
# Copyright (c) 2006/2007 Stefan Ott. All rights reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
# $Id$

/<html>.*<head>/ {
	# Some files don't have proper linebreaks - they'll have <html> and
	# <head> on the same line
	titleStart = index($0, "<title>") + 8;
	titlePart = substr($0, titleStart);

	titleEnd = index($0, "(a Titles ");

	set_show(substr($0, titleStart, titleEnd - titleStart - 1));
}

/^<h1>/ {
	match ($0, /<h1><a href=\".*\">(.*)<\/a><\/h1>/, res)
	set_show(res[1])
}

function set_show(showName) {
	if (SHOW_NAME == "") {
		show = showName
	} else {
		show = SHOW_NAME
	}

	if (VERBOSE == "true") {
		printf " %s...", show
	}
	if (VERY_VERBOSE == "true") {
		printf "\n"
	}
}

/^Season/ {
	season = strtonum($2)
}

/^<a href="guide.shtml#[0-9].*Series/ {
	match ($0, /guide.shtml#([0-9]+)/, res);
	season = res [1]
}

/^ *[0-9]+\./ {
	totalep = substr ($1, 0, index($1, "."))
	gsub (/\.$/, "", totalep)
	epnum = substr($0, 10, 2)
	if (epnum < 10) {
		epnum = 0 substr(epnum, 2, 1)
	}

	prodnum = substr($0, 16, 9)

	match ($0, /([0-9]+ [A-Z][a-z][a-z] [0-9]+)/, res)
	epdate = res [1]
	gsub (/ *$/, "", epdate)

	epnameHTML = substr($0, 40)
	fooIndex = index(epnameHTML, ">")
	eptitle = substr(epnameHTML, fooIndex + 1, length(epnameHTML) - fooIndex - 4)
	gsub (/<$/, "", eptitle);
	
	show_episode(show, totalep, season, epnum, prodnum, epdate, eptitle)
}

BEGIN {
	IGNORECASE = 1
	season = 0
}

END {
	if (VERBOSE == "true") {
		if (dropped == 0) { dropped="0" }
		if (kept == 0) { kept="0" }
		printf "Kept %s, dropped %s. ",kept,dropped
	}
}

function show_episode(show, totalep, season, epnum, prodnum, epdate, eptitle) {
	if (epdate == "") {
		dropped++
		return
	}
	output = format
	command = "date +%Y-%m-%d -d '" epdate "'"
	command | getline airdate
	gsub("&", "and", eptitle)
	gsub("&", "and", show)
	gsub("%show", show, output)
	gsub("%totalep", totalep, output)
	gsub("%season", season, output)
	gsub("%epnum", epnum, output)
	gsub("%prodnum", prodnum, output)
	gsub("%airdate", airdate, output)
	gsub("%eptitle", eptitle, output)
	if (VERBOSE == "true") {
		kept++
	}
	if (VERY_VERBOSE == "true") {
		print "Found " output
	}
	print output >> TMPFILE
}
