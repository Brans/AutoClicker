#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxThreadsPerHotkey 4

TrayTip, Brans' Auto Clicker Loaded, Press Alt+J to Toggle`nPress Ctrl+X to exit, 10


^x::ExitApp ; Press Ctrl+X to exit the script
^!r::Reload ; Reload the script - Ctrl+ALT+R
$!j:: ; Toggle key - Alt+J
t := !t ; Toggle script on/off
loop_start: ; Begin the loop

IniRead, MinSec, conf.ini, RandomSeconds, Min
IniRead, MaxSec, conf.ini, RandomSeconds, Max

Random,RandSec, 367, 1025 

MinSec:= MinSec*1000+RandSec
MaxSec:= MaxSec*1000+RandSec

While t{ ; While toggled, allows the script to be toggled on and off as well
Random,RC, MinSec, MaxSec ; Random interval resets each time the loop begins
Secs:=RC//1000 ; Divide RC by 1000 to easily convert to seconds for the ToolTip and define length of loop below

	Loop %Secs%{ ; Loop for defined scripts

		if t{ ; Run for defined seconds while the script is toggled
		SecR:= Secs-- ; Counts down each tick (1 second)
		ToolTip, Click in %SecR% Secs ; Display the message of when the next click will occur
		sleep, 1000 ; Tick time (1 second)
		}
	}
	SetTimer, RemoveToolTip, 0 ; Remove the ToolTip
	Click, ; Click the left mouse button
	sleep, 100 ; Sleep for 100ms to ensure the script doesn't break anything
	goto, loop_start ; Go back to the begining of the script
}

RemoveToolTip: ; Defining removal of the ToolTip
SetTimer, RemoveToolTip, Off ; Set timer (0 ms) to remove the active ToolTip
ToolTip ; Remove the ToolTip