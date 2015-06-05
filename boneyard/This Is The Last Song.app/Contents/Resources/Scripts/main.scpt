(*
You can rename this script to whatever you want
but please keep this information intact. Thanks.

"This Is The Last Song" for iTunes
written by Doug Adams
dougscripts@mac.com

v2.1 dec 18, 2013
- maintenance update for compatibility with OS X 10.9

v2.0 april 21, 2012
- maintenance update
- universal binary

v1.0 march 23 2004
- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)

property int : 0.5
global finishTime, initialCurrentTrack

on run
	if my checkItunesIsActive() is false then
		set opt to (display dialog "iTunes is not running." buttons {"OK"} default button 1 with title "Cannot proceed..." with icon 0 giving up after 30)
		quit
	end if

	if my itunesIsNotAccesible() is true then
		set opt to (display dialog "Close any utility windows that may be open in iTunes." buttons {"OK"} default button 1 with title "Cannot proceed..." with icon 0 giving up after 30)
		quit
	end if

	initialize()

end run

on idle
	tell application id "com.apple.iTunes"

		try
			if current track is not initialCurrentTrack then error
		on error
			stop
			reveal initialCurrentTrack
			tell me to quit
		end try

		try
			if ((finishTime - (get player position)) - 0.5) as real < int then
				stop
				tell me to quit
			else
				return int
			end if
		on error
			return int
		end try
	end tell
end idle

on initialize()
	tell application id "com.apple.iTunes"
		if player state is playing then
			set initialCurrentTrack to current track
			if class of current track is not URL track then
				set finishTime to (get finish of current track) as real
			else
				tell me to quit
			end if
		else
			tell me to quit
		end if
	end tell
end initialize

to checkItunesIsActive()
	tell application id "com.apple.iTunes" to return running
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

on quit
	continue quit
end quit

