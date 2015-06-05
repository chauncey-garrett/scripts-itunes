(*
"GET Available Podcast Episodes" for iTunes
written by Doug Adams
dougadams@mac.com

v2.1 sept 2, 2010
-- updated for iTunes 10

v2.0 aug 2008
-- compatible with iTunes 7.7.1
-- runs as universal binary
-- minor performance enhancements

v1.1 march 29, 2006
-- fixes an error which listed all undownloaded episodes, not just those from selected podcast subscriptions.

v1.0 january 9, 2006
-- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
http://dougscripts.com/itunes/

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)

property my_title : "GET Available Podcast Episodes"
global undownloaded_episodes
global undownloaded_episode_names

tell application "iTunes"

	-- set ref to "Podcasts" playlist
	try
		set podcasts_playlist to some playlist whose special kind is Podcasts
	on error m
		--log m -- debugging
		display dialog "Cannot access \"Podcasts\" playlist..." buttons {"Cancel"} default button 1 with icon 2 with title my_title giving up after 15
	end try


	-- get name of every subscribed Podcast, sort by alpha
	set all_podcast_albums to my ASCII_Sort(my get_discrete_list_of(get album of every track of podcasts_playlist))
	if all_podcast_albums is {} then
		display dialog "Cannot access any Podcasts..." buttons {"Cancel"} default button 1 with icon 2 with title my_title giving up after 15
	end if


	-- determine which Podcasts have episodes to download
	set podcasts_with_available_episodes to {}
	repeat with a in all_podcast_albums
		if (get every URL track of podcasts_playlist whose album is a) is not {} then
			set end of podcasts_with_available_episodes to a
		end if
	end repeat

	-- choose which Podcast(s) with available episodes to download episode(s) of (!)
	set chosen_podcasts to (choose from list podcasts_with_available_episodes with prompt "Podcasts with episodes to download:" with title my_title with multiple selections allowed)
	if chosen_podcasts is false then return

	-- create list of episodes from chosen Podcasts
	set undownloaded_episode_names to {}
	set undownloaded_episodes to {}
	repeat with this_podcast in chosen_podcasts -- for each listed podcast...
		set undownloaded_episodes to (undownloaded_episodes & (every URL track of podcasts_playlist whose album is this_podcast)) -- these are undownloaded!
	end repeat
	-- get names for choose box
	repeat with i from 1 to (length of my undownloaded_episodes)
		set end of undownloaded_episode_names to (get name of item i of my undownloaded_episodes)
	end repeat

	-- choose episodes
	set get_these to (choose from list undownloaded_episode_names with prompt "GET which episodes?" with title my_title with multiple selections allowed)
	if get_these is false then return


	-- download all chosen episodes
	repeat with get_this in get_these
		try
			with timeout of 3000 seconds
				--log get_this
				set download_this to (some URL track of podcasts_playlist whose name is get_this)
				if (get class of download_this) is list then set download_this to item 1 of download_this
				download download_this
			end timeout
		end try
	end repeat
end tell


to get_discrete_list_of(list1)
	script a
		property list1ref : list1
	end script

	set list2 to {}
	script b
		property list2ref : list2
	end script

	repeat with i from 1 to length of list1
		set this_item to item i of a's list1ref
		considering case
			if this_item is not "" and this_item is not in b's list2ref then set end of list2 to this_item
		end considering
	end repeat

	return b's list2ref

end get_discrete_list_of


-- this is an Apple handler
-- http://www.apple.com/applescript/guidebook/sbrt/pgs/sbrt.05.htm
on ASCII_Sort(my_list)
	set the index_list to {}
	set the sorted_list to {}
	repeat (the number of items in my_list) times
		set the low_item to ""
		repeat with i from 1 to (number of items in my_list)
			if i is not in the index_list then
				set this_item to item i of my_list as text
				if the low_item is "" then
					set the low_item to this_item
					set the low_item_index to i
				else if this_item comes before the low_item then
					set the low_item to this_item
					set the low_item_index to i
				end if
			end if
		end repeat
		set the end of sorted_list to the low_item
		set the end of the index_list to the low_item_index
	end repeat
	return the sorted_list
end ASCII_Sort



