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
;   F8 or 0 or ctrl-shift t : Play music for timed period
;   F7 or 2 or ctrl-shift p : Play / Pause toggle
;   F6 or 3 or Ctrl-Shift ] : Next
;   F5 or 1 or Ctrl-Shift [ : Previous
;   F4 or Down or Ctrl-Shift s : Stop (not toggle)
;   F3 or Left or Ctrl-Shift f : Play (not toggle)
;   Ctrl-Shift - : Vol down
;   Ctrl-Shift = : Vol up


; init
#SingleInstance force
#Persistent
SetTitleMatchMode, 2
DetectHiddenWindows, on

DelayTimeMS := 8000
DelayTimeSec := DelayTimeMS / 1000
varPlaying := false
varHits := 0

; Tray Menu functions. I hope people use this.
menu, tray, add ; separator
menu, tray, add, SetLatchedTime
menu, tray, add, Help


; Main 
Help:
    HelloText =
    (
    Simple Music Latch and Timed player.
    http://code.willwa.de

    1. Configure switch box to F8 (timed) or F7 (latched) or F4/F3 (2-switch)
    2. Open and select music in either iTunes, VLC or Windows Media Player (don't have more than one of these running at the same time!). You may need to press play then pause to get things started correctly. 


    Usage:
        F8 or 0 or ctrl-shift t : Play music for timed period (default 8 secs)
        Ctrl-Shift c : Config window to set the time
        Ctrl-Shift d : View the time period set

        F3 or Left or Ctrl-Shift f : Play (not toggle)
        F4 or Down or Ctrl-Shift s : Stop (not toggle)

        F7 or 2 or ctrl-shift p : Play / Pause toggle
        F6 or 3 or Ctrl-Shift ] : Next
        F5 or 1 or Ctrl-Shift [ : Previous

        Ctrl-Shift - : Vol down
        Ctrl-Shift = : Vol up

        Ctrl-Shift h : This help box
    )
    MsgBox, %HelloText%
return

^+h::
    MsgBox, %HelloText%
return

^+v::
    MsgBox, %varHits%
return


SetLatchedTime:
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

^+c::
    gosub, SetLatchedTime
return

^+d::
    MsgBox % "The value in the variable named DelayTimeSec is " . floor(DelayTimeSec) . "."  
return

F8::
0::
^+t::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
   ControlSend, , {space}, VLC media player
   varPlaying := true
   Sleep, DelayTimeMS
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
   ControlSend, , {space}, VLC media player
   varPlaying := false
   varHits := varHits + 1
return

F7::
2::
^+p::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
   PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
    ControlSend, , {space}, VLC media player
   if (varPlaying) {
      varPlaying := false 
   } else {
       varPlaying := true
    }
   varHits := varHits + 1
return

Left::
^+f::
   if(!varPlaying) {
       DetectHiddenWindows,On
       ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
       PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
            ControlSend, , {space}, VLC media player
       varPlaying = true
    }
   varHits := varHits + 1
return

Down::
^+s::
   if(varPlaying) {
       DetectHiddenWindows,On
       ControlSend, ahk_parent, {space}, iTunes ahk_class iTunes 
       PostMessage,   0x111, 32808, 0,, ahk_class WMPlayerApp
       ControlSend, , {space}, VLC media player
       varPlaying := false
       }
   varHits := varHits + 1
return


F5::
1::
^+[::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{left}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32810, 0,, ahk_class WMPlayerApp
    ControlSend, , {p}, VLC media player
   varHits := varHits + 1
return

F6::
3::
^+]::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{right}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32811, 0,, ahk_class WMPlayerApp
  ControlSend, , {n}, VLC media player
   varHits := varHits + 1
return

^+=::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{up}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32815, 0,, ahk_class WMPlayerApp
    ControlSend,, ^{up}, VLC media player
   varHits := varHits + 1
return

^+-::
   DetectHiddenWindows,On
   ControlSend, ahk_parent, ^{down}, iTunes ahk_class iTunes
   PostMessage,   0x111, 32816, 0,, ahk_class WMPlayerApp
    ControlSend,, ^{down}, VLC media player
   varHits := varHits + 1
return  