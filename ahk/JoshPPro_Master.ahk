SetWorkingDir %A_ScriptDir%
#NoEnv
#Warn
#SingleInstance force
#MaxHotkeysPerInterval 2000

Menu, Tray, Icon, shell32.dll, 283

; JoshPPro
; Last Edit 22/08/2019
; To Add:
; 		- A bunch of Tarans' scripts.

#include %A_ScriptDir%\JoshPPRo_DelExistKeyframes.ahk

;|_______________TEST BAR_______________|
;The spacebar on the macropad. Make sure to press it in the middle.

^!F21::
;id := WinExist("A")
;MsgBox % id
SetKeyDelay, 100
send, {shift down}
send, {Numpad2}
send, {Numpad3}
send, {Numpad2}
send, {shift up}
Return


; ------ Universal -----

;;;Typing Initialism/Acronym expanders

::ffs::for fucks sake
::ty::Thank you
::{}:: ; spaces wavy brackets nicely when typed together
send,{{}
send,{return 2}
send,{}}
send,{up}
return



;;;Save Incremental
^!+G::

ifWinActive, ahk_exe Adobe Premiere Pro.exe
{
Send, ^+S
sleep,500
Send,{right}
Send,{left 7}
Send,+{left 4}
clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
Send ^c
sleep,100
verIn = %clipboard%
send, {end}
;isVerd := RegExMatch(%verIn% %v\d\d\d%)
{
msgbox,yozza
return
}
 Return
}
ifWinActive, ahk_exe AfterFX.exe
{
Msgbox, ae
Return
} 


; ------ Premiere Pro------

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Following commands only work in premiere... until the next Section.

;	----- Import Clips
; Open Import Menu and go to ShotNum
^!F1:: ;F1 on NyquistPad
SetKeyDelay, 100
Send, !a
Send, !d
SetKeyDelay, 100
Send, {Left 18}
Send, {Backspace 2}
Return

;Once Shotnum is replaced, import the latest image sequence
^!F2:: ;F2 on NyquistPad
SetKeyDelay, 100
Send, {End}
Send, {Backspace}
Send, {Up}
Send, {Enter}
SetKeyDelay, 50
Send, {Tab 4}
SetKeyDelay, 10
Send, {Down}
Send, {Up}
Send, {Enter}
Return



;	-------Insert Selected Clip with Correct Range
^!F3:: ;F3 on NyquistPad
SetKeyDelay, 25
Send, +o
Send, {Home}
Send, {Right 5}
Send, i
Send, {End}
Send, {Left 5}
Send, o
Send, .
Send, ^+,
Return



;	-------ManualVersionAddition
; not finished yet
;Send, ^a
;Send, {End}
;Send, test
;Return

;	-------Delete all empty tracks
; delete video tracks
^!F13:: ;PgUp on NyquistPad
SetKeyDelay, 25
Send, !t
Sleep, 300
Send, {Tab 2}
Send, {Space}
Send, {Enter}
Return

; delete audio tracks
^!F18:: ;PgDn on NyquistPad
SetKeyDelay, 25
Send, !t
Sleep, 300
Send, {Tab 4}
Send, {Space}
Send, {Enter}
Return


;	-------Deleted Hovered Rack
;This could be improved by moving the mouse on horizontal so that it can be done from anywhere on the timeline
;Might even be able to locate the padlock icon and use that as reference location
^!F14:: ;Delete on NyquistPad
SetKeyDelay, 25
Click, right
Sleep, 50
Send, d
Send, {Enter}
Return


;	-------Add Track after hovered track
^!F19:: ;End on NyquistPad 
SetKeyDelay, 25
Click, right
Sleep, 50
Send, a
Send, {Enter}
Return


;	-------Insert the specified number of clips with correct range, starting at the selected clip

^!F4:: ;F4 on NyquistPad
InputBox, NumOfClips1, How Many Clips Should Be Added?, Please make sure the first clip is selected
NumOfClips2 := NumOfClips1 - 1

;	First clip
SetKeyDelay, 30
;Shift O sends the selected clip to source
Send, +o
;Selects the correct frame range for the clip by trimming head and tail
Sleep, 50
Send, {Home}
Sleep, 50
SetKeyDelay, 80
Send, {Right 5}
SetKeyDelay, 30
Send, i
Send, {End}
Sleep, 50
SetKeyDelay, 80
Send, {Left 5}
SetKeyDelay, 30
Send, o
;inserts clip at playhead on patch track
Send, .
Sleep, 50
;left by one panel, returning to the bin.
Send, ^+,

;	Following Clips
; loops for the number of times stated, minus one.
loop %NumOfClips2%
{
SetKeyDelay, 30
;go to the next clip
Send, {Down}
Send, +o
Sleep, 50
Send, {Home}
Sleep, 50
SetKeyDelay, 80
Send, {Right 5}
SetKeyDelay, 35
Send, i
Send, {End}
Sleep, 50
SetKeyDelay, 80
Send, {Left 5}
SetKeyDelay, 35
Send, o
Send, .
Sleep, 50
Send, ^+,
}
Return

; ------ After Effects Scripts ------
; Following commands only work in AfterFX... until the next Section.
#IfWinActive ahk_exe Adobe AfterFX.exe

;Change Framerate to 25
;ctl alt g 25 enter when clip selected
#IfWinActive ahk_exe AfterFX.exe
^!F15:: ;ScrollLock on NyquistPad
SetKeyDelay, 25
Send, ^!g
Send, 25
Send, {Enter}
Return

;Change framerate to specified, for the specified number of clips
;-- could merge these two with premiere and have them be app dependent

;New Sequence from file (CHM Layer), named properly
^!F20:: ;Subtract on NyquistPad
Send, !\
sleep, 100
Send, ^k
Send, {right}
Send, {backspace 4}
Send, {enter}
return

;Freeze BG backwards
^!F16:: ;Pause on NyquistPad
SetKeyDelay, 100
send, ^!+{right}
send, ^{right}
send, {Numpad2}
send, ^+d
send, {Numpad3}
send, !t
send, {home}
send, ![
send, {Numpad3}
send, ^d
send, {Numpad2}
send, ^d
send, {Numpad3}
send, ^!+{down}
send, {Numpad4}
send, ^!+{down}
return



;Freeze BG forwards
^!F17:: ;Insert on NyquistPad
return




; ------ Premiere Pro & After Effects Scripts ------
