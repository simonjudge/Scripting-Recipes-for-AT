#SingleInstance force


Numpad7::KeyBD("()[]1")
Numpad8::KeyBD("ABC2@")
Numpad9::KeyBD("DEF3#")
Numpad4::KeyBD("GHI4$")
Numpad5::KeyBD("JKL5%")
Numpad6::KeyBD("MNO6^")
Numpad1::KeyBD("PQRS7&")
Numpad2::KeyBD("TUV8~")
Numpad3::KeyBD("WXYZ9'")
Numpad0::KeyBD(" +-*/\0")
NumpadDot::KeyBD(".,?!'")

NumpadAdd::          ; ~CapsLock
Return
NumpadDiv::          ; ~CapsLock
   Caps:=!Caps
   TrayTip,,Caps = %Caps%
Return
$NumpadEnter::Send {Enter}
  
KeyBD(list)
{
   Static i          ; index of the character in the list, to be sent
   Global Caps, Mod, c
   If (A_ThisHotKey = A_PriorHotKey )
   {
      IfEqual Mod,,Send {BS} ; erase the char this key has inserted
      i++            ; index of next char, wrapped around
      IfGreater i,% StrLen(list), SetEnv i,1
   }
   Else i = 1        ; at new key send first char from list
   StringMid c, list, i, 1
   IfEqual Mod,, {
      IfEqual Caps,1, StringUpper c,c
      Else            StringLower c,c
      SendRaw %c%    ; send selected
   }
}
