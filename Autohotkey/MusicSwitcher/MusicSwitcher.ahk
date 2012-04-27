; iTunes & Windows Media Player Control for Switch Practice and development
; Language:       English
; Platform:       Win9x/NT
; Author:         Will Wade (
; Adapted from a script by Shawn Mollen : http://www.autohotkey.com/community/viewtopic.php?t=23267
;
; Script Function:
;   Controls both iTunes and Windows Media Player using hotkeys.
;   Functions when maximized, minimized to taskbar, or minimized to system tray.
; 
; Controls
;   Ctrl-Shift c : Config window to set the time
;   Ctrl-Shift d : View the time period set
;   F8 or ctrl-shift t : Play music for timed period
;   F7 or ctrl-shift p : Play / Pause toggle
;   F6 or Ctrl-Shift ] : Next
;   F5 or Ctrl-Shift [ : Previous
;   F4 or Ctrl-Shift f : Play (not toggle)
;   F3 or Ctrl-Shift s : Stop (not toggle)
;   Ctrl-Shift - : Vol down
;   Ctrl-Shift = : Vol up

DelayTimeMS := 5000
DelayTimeSec := DelayTimeMS / 1000
varPlaying := false

HelloText =
(
Simple Music Latch and Timed player.
http://code.willwa.de

1. Configure switch box to F8 (timed) or F7 (latched) or F4/F3 (2-switch)
2. Open and select music in either iTunes or Windows Media Player (not both)

Usage:
    Ctrl-Shift c : Config window to set the time
    Ctrl-Shift d : View the time period set
    F8 or ctrl-shift t : Play music for timed period
    F7 or ctrl-shift p : Play / Pause toggle
    F6 or Ctrl-Shift ] : Next
    F5 or Ctrl-Shift [ : Previous
    F4 or Ctrl-Shift f : Play (not toggle)
    F3 or Ctrl-Shift s : Stop (not toggle)
    Ctrl-Shift - : Vol down
    Ctrl-Shift = : Vol up
)

MsgBox, %HelloText%

^+c::
    Gui, Add, Text,, Delay Time (seconds):
    Gui, Add, Slider, vDelayTimeSec Vertical ToolTip, %DelayTimeSec%
    Gui, Add, Button, default, OK
    Gui, Show,, Simple Input Example
    return  
    
    GuiClose:
    ButtonOK:
    Gui, Submit 
    DelayTimeMS := DelayTimeSec * 1000
    MsgBox % "The latched time to play music is " . floor(DelayTimeSec) . " seconds."  
    Gui, Destroy
return

^+d::
    MsgBox % "The value in the variable named DelayTimeSec is " . floor(DelayTimeSec) . "."  
return

F8::
^+t::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
   varPlaying := true
   Sleep, DelayTimeMS
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
   varPlaying := false
return

F7::
^+p::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
   if (varPlaying) {
      varPlaying := false 
   } else {
       varPlaying := true
    }
return

F4::
^+f::
   if(!varPlaying) {
       DetectHiddenWindows,On
       ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
       PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
       varPlaying = true
    }     
return

F3::
^+s::
   if(varPlaying) {
       DetectHiddenWindows,On
       ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
       PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
       varPlaying := false
       }
return


F5::
^+[::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{left}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32810, 0,, ahk_class WMPlayerApp
return

F6::
^+]::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{right}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32811, 0,, ahk_class WMPlayerApp
return

^+=::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{up}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32815, 0,, ahk_class WMPlayerApp
return

^+-::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{down}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32816, 0,, ahk_class WMPlayerApp
return  