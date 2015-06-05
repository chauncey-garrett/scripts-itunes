(*
You can rename this script to whatever you want
but please keep this information intact. Thanks.

"Just Play This One" for iTunes
written by Doug Adams
dougscripts@mac.com

v3.0
-- completely re-written--older versions are obsolete
-- universal binary

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)


tell application "iTunes"
	set sel to selection
	if sel is not {} and length of sel is 1 then
		try
			play item 1 of selection with once
		on error
			beep
		end try
	end if
end tell


