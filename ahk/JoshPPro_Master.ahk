SetWorkingDir %A_ScriptDir%
#NoEnv
#Warn
#SingleInstance force
#MaxHotkeysPerInterval 2000

Menu, Tray, Icon, shell32.dll, 13

Run, QuickLinks.ahk
Run, JoshPPro_RClickMovePlayhead.ahk

; JoshPPro
; Last Edit 22/08/2019
; To Add:
; 		- A bunch of Tarans' scripts.
;		- "ergonomic break" reminder
;		- app switcher keys (needs update)
;		- path paster with QuickLinks GUI that takes the path and presses ^L Enter
;		- automatic FX applier for Z, DoF, and RSMB
;

#include %A_ScriptDir%\JoshPPRo_DelExistKeyframes.ahk


;________________________________________________________________
;Universal
;________________________________________________________________

;;;Typing Initialism/Acronym expanders

::ffs::for fucks sake

::ty::thank you

::jsyk::just so you know

::jsik::just so i know

::wth:: ;this could be better
Random, wthrand , 1, 4
if (wthrand = 1) {
send, what the hell
return
}
if (wthrand = 2) {
send, what to heck
return
}  
if (wthrand = 3) {
send, wth
return
}
if (wthrand = 4) {
send, what the hellll
return
}
return

affm1=Hello! 
affm2=Hi! 
affm3=Good day! 
affm4=Hello World! 
::asdf:: 
Random, output, 1, 4 
send % affm%output%
send {enter}
return


option1=one
option2=two
option3=three
option4=four

::qwer::
Random, output, 1, 4
Send, % option%output%
return




::{}:: ; spaces wavy brackets nicely when typed together
send,{{}
send,{return 2}
send,{}}
send,{up}
return

;;create chm and bg folders
^!F19:: ;;;;this is the wrong way to do this btw
setkeydelay, 15
send ^+n
send +b
send +g
send {return}
send ^+n
send +c
send +h
send +m
send {return}
return

;;;Save Incremental
^!+G::

;;;Copy Hangouts Text
^!F7::
Click, 3
send ^c
Return

;ifWinActive, ahk_exe Adobe Premiere Pro.exe
;{
;Send, ^+S
;sleep,500
;Send,{right}
;Send,{left 7}
;Send,+{left 4}
;clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
;Send ^c
;sleep,100
;verIn = %clipboard%
;send, {end}
;;isVerd := RegExMatch(%verIn% %v\d\d\d%)
;{
;msgbox,yozza
;return
;}
; Return
;}
;ifWinActive, ahk_exe AfterFX.exe
;{
;Msgbox, ae
;Return
;} 


;Switchers______________________________________


#IfWinActive


windowSaver()
{
WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window
global savedCLASS = "ahk_class "lolclass
global savedEXE = lolexe ;is this the way to do it? IDK.
;msgbox, %savedCLASS%
;msgbox, %savedEXE%
}

;SHIFT + macro key G14


global savedCLASS = "ahk_class Notepad++"
global savedEXE = "notepad++.exe"

switchToSavedApp(savedCLASS)
{
;msgbox,,, savedCLASS is %savedCLASS%,0.5
;msgbox,,, savedexe is %savedEXE%,0.5
if savedCLASS = ahk_class Notepad++
	{
	;msgbox,,, is notepad++,0.5
	if WinActive("ahk_class Notepad++")
		{
		sleep 5
		Send ^{tab}
		}
	}

;msgbox,,,got to here,0.5
windowSwitcher(savedCLASS, savedEXE)
}





back(){
;; if WinActive("ahk_class MozillaWindowClass")
;tooltip, baaaack
;sendinput, {ctrl up}
If GetKeystate(Lctrl, "P")
        Send {Lctrl Up}
If GetKeystate(Rctrl, "P")
        Send {Rctrl Up}

if WinActive("ahk_exe firefox.exe")
	Send ^+{tab}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_class Notepad++")
	Send ^+{tab}
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	Send ^!+b ;ctrl alt shift B  is my shortcut in premiere for "go back"(in bins)(the project panel)
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
if WinActive("ahk_class OpusApp")
	sendinput, {F2} ;"go to previous comment" in Word.
}

;macro key 16 on my logitech G15 keyboard. It will activate firefox,, and if firefox is already activated, it will go to the next window in firefox.

switchToFirefox(){
sleep 16 ;So this is here because I think that with the way I have iCUE set up, it won't always get to the Right CTRL UP event because it's no longer on that profile, you know what I mean? So this gives it a bit more time to do that.

sendinput, {SC0E8} ;scan code of an unassigned key. Do I NEED this?



IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_exe firefox.exe")
	{
	WinGetClass, class, A
	if (class = "Mozillawindowclass1")
		msgbox, this is a notification
	}
if WinActive("ahk_exe firefox.exe")
	{
	Send ^{tab}
	}
else
	{
	;WinRestore ahk_exe firefox.exe
	;WinActivate ahk_exe firefox.exe ;was winactivatebottom before...
	;WinActivatebottom ahk_class MozillaWindowClass ;was winactivatebottom before...
	WinActivate ahk_class MozillaWindowClass ;was winactivatebottom before...
	;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
	;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
	}
sleep 2
;now to unstick any potentially stuck modifier keys
; KeyList := "Shift|Rctrl|alt"
; Loop, Parse, KeyList, |
	; {
	; If GetKeystate(A_Loopfield, "P")
		; Send % "{" A_Loopfield " Up}"
	; }

send, {Rctrl up} ;This SHOULD work, but i think it doesn't because the RCTRL event is still coming from the keyboard itself. I need to make something that will send RCTRL up and double click that shit and then see if it makes any difference at all next time. hmm.
;okay, I've created RCTRL UP.AHK to test this. Just doble clicking on it will send a RCTRL UP event. This is important because it's not being done through the keyboard. Will try that next time this shizz happens.
send, {Lctrl up}

}



#IfWinActive
;Press SHIFT and macro key 16, and it'll switch between different WINDOWS of firefox.

switchToOtherFirefoxWindow(){
;sendinput, {SC0E8} ;scan code of an unassigned key
Process, Exist, firefox.exe
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, firefox.exe
	else
	{
	GroupAdd, taranfirefoxes, ahk_class MozillaWindowClass
	if WinActive("ahk_class MozillaWindowClass")
		GroupActivate, taranfirefoxes, r
	else
		WinActivate ahk_class MozillaWindowClass
	}
}



; This is a script that will always go to The last explorer window you had open.
; If explorer is already active, it will go to the NEXT last Explorer window you had open.
; CTRL Numpad2 is pressed with a single button stoke from my logitech G15 keyboard -- Macro key 17. 

switchToExplorer(){
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.

;maybe need to unstick modifiers
sleep 2
send, {Rctrl up}
send, {Lctrl up}
;IDK if that even works...
}

; ;trying to activate these windows in reverse order from the above. it does not work.
; ^+F2::
; IfWinNotExist, ahk_class CabinetWClass
	; Run, explorer.exe
; GroupAdd, taranexplorers, ahk_class CabinetWClass
; if WinActive("ahk_exe explorer.exe")
	; GroupActivate, taranexplorers ;but NOT most recent.
; else
	; WinActivatebottom ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
; Return

;closes all explorer windows :/
;^!F2 -- for searchability

closeAllExplorers()
{
WinClose,ahk_group taranexplorers
; i want to improve this so that the bottom (most recently active) explorer window does NOT close. IDK how to do that yet though.
; https://stackoverflow.com/questions/39601787/close-windows-explorer-window-with-auto-hotkey
; https://autohotkey.com/board/topic/88648-close-all-explorer-windows/
}


switchToPremiere(){
IfWinNotExist, ahk_class Premiere Pro
	{
	;Run, Adobe Premiere Pro.exe
	;Adobe Premiere Pro CC 2017
	; Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
	Run, Adobe Premiere Pro.exe
	}
if WinActive("ahk_class Premiere Pro")
	{
	IfWinNotExist, ahk_exe notepad++.exe
		{
		Run, notepad++.exe
		sleep 200
		}
	WinActivate ahk_exe notepad++.exe ;so I have this here as a workaround to a bug. Sometimes Premeire becomes unresponsive to keyboard input. (especially after timeline scrolling, especially with a playing video.) Switching to any other application and back will solve this problem. So I just hit the premiere button again, in those cases.g
	sleep 10
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro

;maybe need to unstick modifiers
sleep 2
send, {Rctrl up}
send, {Lctrl up}
;IDK if that even works...
}


switchToWord()
{
;tooltip, why
Process, Exist, WINWORD.EXE
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	IfWinExist, Microsoft Office Word, OK ;checks to see if the annoying "do you want to continue searching from the beginning of the document" dialouge box is present.
		sendinput, {escape}
	else if WinActive("ahk_class OpusApp")
		sendinput, {F3} ;set to "go to next comment" in Word.
	else
		WinActivate ahk_class OpusApp
	}
;maybe need to unstick modifiers
sleep 2
send, {Rctrl up}
send, {Lctrl up}
;IDK if that even works...
}


switchWordWindow()
{
; Process, Exist, WINWORD.EXE
; ;msgbox errorLevel `n%errorLevel%
	; If errorLevel = 0
		; Run, WINWORD.EXE
	; else
	; {
	GroupAdd, taranwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, taranwords, r
	else
		WinActivate ahk_class OpusApp
	; }
}



switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

if WinActive("ahk_exe chrome.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe chrome.exe
;maybe need to unstick modifiers
sleep 2
send, {Rctrl up}
send, {Lctrl up}
;IDK if that even works...
}

switchToStreamDeck(){
IfWinNotExist, ahk_exe StreamDeck.exe
	{
	Run, C:\Program Files\Elgato\StreamDeck\StreamDeck.exe
	}
else
	{
	WinActivate ahk_exe StreamDeck.exe
	}
}


#IfWinActive
windowSwitcher(theClass, theEXE)
{
;if savedCLASS = Chrome_WidgetWin_1
if theCLASS = Chrome_WidgetWin_1
	{
	msgbox, it is a chrome thingy
	if theEXE = Teams.exe
		WinActivate %theEXE%
		goto, switchEND
	}

;msgbox,,, switching to `nsavedCLASS = %theClass% `nsavedEXE = %theEXE%, 0.5
IfWinNotExist, %theClass%
	Run, % theEXE
if not WinActive(theClass)
	WinActivate %theClass%
switchEND:
}

;Switchers_HotKeys______________________________________

^!+F14::switchToExplorer()


;________________________________________________________________
;Premiere Pro
;________________________________________________________________

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


;________________________________________________________________
;After Effects
;________________________________________________________________

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
^!F13:: ;black1
Send, !\
sleep, 100
Send, ^k
Send, {right}
Send, {backspace 9}
Send, {enter}
sleep, 300
Click
sleep, 300
send, {down 2}
send, ^/			;---send selected clip to comp (goes to top)
send, {Numpad1}
send, ^!+{down}
send, ^d
send, {Numpad3}
send !s
return

;New Sequence and apply FX presets
;^!F16:: ;black row1 col4
;send !\				;new seq from clip
;sleep, 100
;Send, ^k
;Send, {right}
;Send, {backspace 9}
;Send, {enter}		;removed _LGT_1001

;select mpt and drop below lgt
;duplicate mpt
;numpad3 and ctl alt shift v to disable vis
;numpad3 and apply zdepth preset
;numpad2 and apply dof preset
;numpad1 and apply rsmb preset
;numpad2 to allow dof to changes to fx
;somethin like that
return


;Freeze BG backwards
^!F14:: ;black2
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
^!F17:: ;row 1 col 5
setkeydelay, 25
send, {Numpad2}
send, ^+{down}
send, ^d
send, o
send, !t
send, ![
send, {end}
send, !]
send, {Numpad4}
send, ^{up}
send, {Numpad5}
send, ^+{up}
send, ^+c
sleep, 250
send, {backspace}
send, Z
send, {enter}
return

;Freeze BG backwards
^!F18::
return

;Set as zdepth in extractor
^!F20::
send {click}
send +{tab}
send z
send +{tab 2}
send z
send +{tab}
send z
send +{tab}
send z
send +{tab 2}
send {return}
return

;Create Mirror Shot
^!F21::  ; row 2 col 3
BlockInput On
send ^d				;ctl d, enter, rename LGT to MIR
sleep, 100
Send, {enter}
send, {home}
Send, {right 14}
Send, {delete 3}
send, MIR
send, {end}
send, {backspace 2}
send, {enter}
sleep, 100
send ^!g			;---ctl alt g, shift tabx2, upx2, enter
sleep, 100			
send +{tab 2}
send {up 2}
send {enter}
send {up}			;---up, and create sequence
send !\				;---new seq from clip
sleep, 100
Send, ^k
Send, {right}
Send, {backspace 9}
Send, {enter}		;---removed _LGT_1001
sleep, 300
Click
send, {down 2}
send, ^/			;---send selected clip to comp (goes to top)
send, {Numpad1}
send, ^!+{down}
BlockInput Off
return
;---end of script? till i figurre out how to sel panes properly
;---drag MIR below and duplicate, apply EXt preset, and set matte


;---Create New Lumetri
^!F16:: ;black row1 col4
blockinput on
SetKeyDelay, 25
Click, right
sleep, 100
send {up}
send ccc
send {right}
send llll
send {enter}
blockinput off
return

;________________________________________________________________
;Premiere Pro & After Effects
;________________________________________________________________