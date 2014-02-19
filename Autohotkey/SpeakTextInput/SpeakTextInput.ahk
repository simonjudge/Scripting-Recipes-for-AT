; Hacked together script to read out all text entered on keyboard.
; Hacked from key recording scripts: http://www.autohotkey.com/board/topic/73858-looking-for-efficient-key-logger-script/ 
;

; Instructions: Run this script.
; Change the speaking rate of the voice to suit you.  You will probably need it pretty quick.
; Control Panel -> Speech -> Text to Speech -> Fast.

; This is VERY basic.  There are more powerful text to speech programs out there that you may want to consider -e.g. Penfriend or ClaroSpeak...

; No warranty, as normal!  Simon Judge.

#SingleInstance
Voice:=ComObjCreate("SAPI.SpVoice")

SetFormat, Integer, H
Loop, 0x7f
Hotkey, % "*~" . chr(A_Index), SpeakKey
Return

SpeakKey:
Key := RegExReplace(SubStr(A_ThisHotkey,0),"^0x")
Voice.Speak(Key)

Return
