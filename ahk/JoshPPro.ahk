; JoshPPro
; Last Edit 21/08/2019


; Open Import Menu and go to ShotNum
!1::
SetKeyDelay, 10
Send, !a
Send, !d
Send, {Left 18}
Return

;Once Shotnum is replaced, import the latest image sequence
!2::
SetKeyDelay, 10
Send, {End}
Send, {Backspace}
Send, {Up}
Send, {Enter}
SetKeyDelay, 100
Send, {Tab 4}
SetKeyDelay, 10
Send, {Down}
Send, {Up}
Send, {Enter}
Return

;Insert Clip Below Cursor with Correct Range
!z::
InputBox, NumOfClips, How Many Clips Should Be Added?

SetKeyDelay, 10
Click, 2
Send, {Home}
Send, {Right 5}
Send, i
Send, {End}
Send, {Left 5}
Send, o
Send, .
Return

;Insert the specified number of clips with correct range, starting at the selected clips

!3::
;	First clip
SetKeyDelay, 10
Send, +o
Send, {Home}
Send, {Right 5}
Send, i
Send, {End}
Send, {Left 5}
Send, o
Send, .
Send, ^+,

;	Following Clips
SetKeyDelay, 10
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


;test command
!m::
InputBox, OutputVar, Question 1, What is your first name?
if (OutputVar = "Bill")
    MsgBox, That's an awesome name`, %OutputVar%.

InputBox, OutputVar2, Question 2, Do you like AutoHotkey?
if (OutputVar2 = "yes")
    MsgBox, Thank you for answering %OutputVar2%`, %OutputVar%! We will become great friends.
else
    MsgBox, %OutputVar%`, That makes me sad.
Return
