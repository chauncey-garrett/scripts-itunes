--
-- Play iTunes, opening if needed
--

on run arguments
	if ((count of arguments) is 0) or (first item of arguments) is not "paused" then
		tell application "Finder"
			if process "iTunes" exists then
				tell application "iTunes" to play
			end if
		end tell
	end if

	return arguments
end run


