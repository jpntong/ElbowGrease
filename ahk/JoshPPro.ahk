; JoshPPro
; Last Edit 22/08/2019


; ------ Premiere Pro------

;	------- Import Clips
; Open Import Menu and go to ShotNum
^!F1::
SetKeyDelay, 100
Send, !a
Send, !d
SetKeyDelay, 10
Send, {Left 18}
Send, {Backspace 2}
Return

;Once Shotnum is replaced, import the latest image sequence
^!F2::
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
^!F3::
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
Send, ^a
Send, {End}
Send, test
Return

;	-------Delete all empty tracks
; delete video tracks
^!F13::
Send, !t
Sleep, 300
Send, {Tab 2}
Send, {Space}
Send, {Enter}
Return

; delete audio tracks
^!F18::
Send, !t
Sleep, 300
Send, {Tab 4}
Send, {Space}
Send, {Enter}
Return


;	-------Deleted Hovered Rack
;This could be improved by moving the mouse on horizontal so that it can be done from anywhere on the timeline
;Might even be able to locate the padlock icon and use that as reference location
^!F14::
Click, right
Send, d
Send, {Enter}
Return


;	-------Add Track after hovered track
^!F19::
Click, right
Send, a
Send, {Enter}
Return


;	-------Insert the specified number of clips with correct range, starting at the selected clip

^!F4::
InputBox, NumOfClips1, How Many Clips Should Be Added?, Please make sure the first clip is selected
NumOfClips2 := NumOfClips1 - 1

;	First clip
SetKeyDelay, 25
;Shift O sends the selected clip to source
Send, +o
;Selects the correct frame range for the clip by trimming head and tail
Send, {Home}
Send, {Right 5}
Send, i
Send, {End}
Send, {Left 5}
Send, o
;inserts clip at playhead on patch track
Send, .
;left by one panel, returning to the bin.
Send, ^+,

;	Following Clips
; loops for the number of times stated, minus one.
loop %NumOfClips2%
{
SetKeyDelay, 25
;go to the next clip
Send, {Down}
Send, +o
Send, {Home}
Send, {Right 5}
Send, i
Send, {End}
Send, {Left 5}
Send, o
Send, .
Send, ^+,
}
Return



;test command
!m::
Return