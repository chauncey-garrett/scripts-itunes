(*
"Unfinished Podcast Episodes" for iTunes
written by Doug Adams
dougadams@mac.com

v1.0 june 24, 2014
-- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

*)

property collectionPlaylistName : "[-Unfinished Podcast Episodes>"

on run
	tell application "iTunes"
		set theEpisodes to (get every file track of (get some playlist whose special kind is Podcasts))
		set theCollectionPlaylist to my makeCollectionPlaylist()
		reveal theCollectionPlaylist
		repeat with thisEpisode in theEpisodes
			try
				tell thisEpisode to set {dur, bkmk} to {duration, bookmark}
				if bkmk > 0.0 and bkmk < dur then my processThisTrack(thisEpisode, theCollectionPlaylist)
			end try
		end repeat
	end tell
end run

to processThisTrack(theTrack, thePlaylist)
	tell application "iTunes"
		if not (exists (some track of thePlaylist whose persistent ID is (get persistent ID of theTrack))) then
			try
				duplicate theTrack to thePlaylist
			end try
		end if
	end tell
end processThisTrack

on makeCollectionPlaylist()
	tell application "iTunes"
		if not (exists (some playlist whose name is collectionPlaylistName)) then
			set newPlaylist to (make new playlist with properties {name:collectionPlaylistName})
		else
			set newPlaylist to (some playlist whose name is collectionPlaylistName)
			try
				delete every track of newPlaylist
			end try
		end if
		return newPlaylist
	end tell
end makeCollectionPlaylist

