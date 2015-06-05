(*
"Search/Replace Tag Text" for iTunes
written by Doug Adams
dougscripts@mac.com

v3.4 jan 12 2013
- makes window user-resizable
- updates menu GUI

v3.3 sept 11 2012
- provides traditional search fields
- minor code tweaks

v3.2 july 30 2012
- compatible with OS X 10.8

v3.1 february 2 2012
- fixes text escaping problem
- fixes issue with non-results included in dry run display
- fixes error when Grouping tag selected for search
- adds close and minmize buttons
- other minor finesses

v3.0 november 30 2011
- written as Cocoa-AppleScript applet for OS 10.6 or 10.7 only
- consolidates options to single window
- adds additional tags
- adds case sensitivity and whole word matching
- adds "dry run" preview
- adds progress indicator

v2.0 april 20 2010
- maintenance release
- universal binary

v1.0 March 6 2005
- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)



property mainWindow : class "mainWindow"

-- local objects
property workArea : {}
property myTitle : "Search-Replace Tag Text"

on run
	if (accessHook() is false) then
		try
			tell me to quit
		on error m
			log m
			return
		end try
	end if

	tell mainWindow to set workArea to alloc()'s init()
	tell workArea to |launch|:me
end run

on accessHook()
	if my checkItunesIsActive() is false then
		set opt to (display dialog "iTunes is not running." buttons {"OK"} default button 1 with title "Cannot proceed..." with icon 0 giving up after 30)
		return false
	end if

	if my itunesIsNotAccesible() is true then
		set opt to (display dialog "Close any utility windows that may be open in iTunes." buttons {"OK"} default button 1 with title "Cannot proceed..." with icon 0 giving up after 30)
		return false
	end if

	if my isFullScreen() then
		log "iTUNES IS IN FULL SCREEN MODE"
		delay 0.5
		set opt to (display alert "iTunes is in full screen mode." message "This applet's interface cannot be displayed with iTunes while in full screen mode.

You can Quit and re-launch this applet after taking iTunes out of full screen mode.

Or you can Proceed Anyway, but iTunes will not be visible while the applet is running." buttons {"Quit", "Proceed Anyway"} default button 1 as warning giving up after 30)
		if button returned of opt is "quit" then
			tell application "iTunes" to activate
			return false
		end if
	end if

	return true
end accessHook

to checkItunesIsActive()
	tell application "System Events" to return (exists (some process whose name is "iTunes"))
end checkItunesIsActive

on itunesIsNotAccesible()
	try
		with timeout of 1 second
			tell application id "com.apple.iTunes" to get name of library playlist 1
		end timeout
	on error
		return true
	end try
	return false
end itunesIsNotAccesible

on isFullScreen()
	try
		tell application "System Events"
			tell process "iTunes"
				return (get value of attribute "AXFullScreen" of window 1)
			end tell
		end tell
	on error
		return false
	end try
end isFullScreen

