Sleep, 3000
WinGet, OutName
WinActivate

WinGetPos, xpos, ypos
CoordMode, Mouse, Screen
MouseMove, xpos, ypos
CoordMode, Mouse, Relative
MouseMove, 50, 50
MouseGetPos, xpos, ypos
val := 50/xpos
MsgBox, %val%