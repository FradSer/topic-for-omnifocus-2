(*
	Topic.applescript
	By Frad Lee of [Hello from FradSer](http://fradser.me).
	See README for details.
*)

-- PROPS
property isNotify : "no"

property scriptSuiteName : "Frad's Scripts"

-- MAIN
set newTopic to missing value
tell application "OmniFocus"
	tell front document
		tell content of document window 1
			set allTask to value of (every descendant tree where class of its value is task)
			repeat with anTask in allTask
				if name of anTask contains "$topic" then
					set anProject to containing project of anTask
					set projectNote to note of anProject
					set newTopic to do shell script "echo '" & projectNote & "' | sed -n '/$topic: /p' | sed 's/$topic: //g'"
					set taskTitle to name of anTask
					set name of anTask to do shell script "echo '" & taskTitle & "' | sed 's/$topic/#" & newTopic & " /g'"
					if (newTopic is not missing value) and (isNotify is "yes") then
						my notify("Changed topic.", newTopic)
					end if
				end if
			end repeat
		end tell
	end tell
end tell

-- NOTIFY

on notify(theTitle, theDescription)
	display notification theDescription with title scriptSuiteName subtitle theTitle
end notify

