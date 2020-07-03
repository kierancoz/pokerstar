; Make sure to set "Remember me" checkmark
; Make sure to pin club to top of list


; Kill PokerStars.exe
Run, %ComSpec% /k START /wait taskkill /f /im PokerStars.exe && exit
; Wait and then restart PokerStars.exe
Sleep, 1000
Run, "C:\Program Files (x86)\PokerStars.NET\PokerStarsUpdate.exe"
; Set focus & login
WinTitle := "PokerStars Lobby"
WinWait %WinTitle%
WinActivate
; WinGetPos, xpos, ypos
Sleep, 5000
MouseMove, 275, 430, 25
Click
; Check for unexpected exit popup
; Check for news popup
; Hit Home Games
Sleep, 5000
WinActivate
MouseMove, 1220, 700, 25
Click
; Double click on top club
Sleep, 5000
WinActivate
MouseMove, 400, 285, 25
Click
Sleep, 100
Click
; Resize popup application & set focus
SetTitleMatchMode, RegEx


; Click on results tab
; Double click on tournament
; Resize popup application & set focus
; Take screenshot of portion of screen
; Save screenshot to designated folder with guid (datetime)
; Run compiled python file with guid as arg