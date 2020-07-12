; Make sure to set "Remember me" checkmark
; Make sure to pin club to top of list

#include RunInfo.txt

; Main
KillPokerStar(PokerApp)
if GetMainLobby(PokerApp, PokerPath)
{
    Sleep, 500
    if GetMonitorScale() != 1.000
        MsgBox, Scale issue! Unable to run program: multiple monitor issue with autohotkey

    if GetClubLobby(PokerApp)
    {
        if GetTournamentLobby(PokerApp)
        {
            ; Take screenshot of winning area of tournament screen
            ImageLocation := A_Args[1]
            name = %ImageLocation%\%A_Now%
            ControlGetPos, x, y, w, h, PokerStarsListClass8
            Process, Close, SnippingTool.exe
            ScreenshotCoords(x,y,x+w,y+h, name, SnippingPath)
            Process, Close, SnippingTool.exe
        }
        else
            MsgBox, Failed to load Active Tournament Lobby screen
    }
    else
        MsgBox, Failed to load Club Lobby screen
}
else
    MsgBox, Failed to load Main Lobby screen
KillPokerStar(PokerApp)
; End Main

; Work in progress
GetMonitorScale()
{
    WinGetPos, xpos, ypos
    CoordMode, Mouse, Screen
    MouseMove, xpos, ypos
    CoordMode, Mouse, Relative
    MouseMove, 50, 50
    MouseGetPos, xpos, ypos
    return 50/xpos
}

ScreenshotCoords(x1,y1,x2,y2, savePath, snippingPath)
{
    ; take screenshot
    WinGetPos, WinX, WinY, WinW, WinH, A
    Sleep, 2000
    Run, "%snippingPath%"
    WinActivate, ahk_exe SnippingTool.exe
    Sleep, 2000
    Send ^n
    Sleep, 1000
    CoordMode, Mouse, Screen
    MouseClickDrag, Left, WinX+x1, WinY+y1, WinX+x2, WinY+y2
    Sleep, 100
    ; Save screenshot to designated folder  based on datetime
    Send ^s
    Send %savePath%
    Send {Enter}
}

GetTournamentLobby(appName)
{
    ; Click on schedule tab
    WinGetPos, x, y, w, h
    MouseMove, w/4, 167
    Click
    ; Sort by Date order (Gets most recent tournament)
    ControlGetPos, x, y,,,PokerStarsListClass8 ; PROBLEMS HERE
    MouseMove, x+10, y-20
    DoubleClick()
    ; Double click on target tournament (how to figure out which one is target, not sure yet)
    MouseMove, x+10, y+10 ; clicking on most recent one right now (temporary)
    DoubleClick()
    ; Activate "Tournament ~numbers~ Lobby"
    return ActivateTournamentLobby(appName)
}

ActivateTournamentLobby(appName)
{
    ; Activate "Tournament ~numbers~ Lobby"
    SetTitleMatchMode, RegEx
    WinWait, i)^(Tournament ) ahk_exe %appName%, ,10
    if ErrorLevel
        return False
    WinActivate
    return True
}

GetClubLobby(appName)
{
    ; TODO: Check for unexpected exit popup
    ; Check for news popup if exists
    WinKill, My News
    ; Hit Home Games
    WinActivate
    ControlGetPos, x, y, w, h, CWidgetBase2
    MouseMove, x+w-30, y+450 ; 585 on small screen (screen ratio problem..), 450 on big
    Click
    ; Double click on top club
    Sleep, 1000
    ControlGetPos, x, y,,,PokerStarsListClass1 ; PROBLEMS HERE
    MouseMove, x+40, y+15
    DoubleClick()
    ; Activate "Club # Lobby" windows
    Sleep, 1000
    SetTitleMatchMode, RegEx
    WinWait i)^(Club #) ahk_exe %appName%, ,10
    if ErrorLevel
        return False
    WinActivate
    Sleep, 1000
    return True
}

KillPokerStar(appName)
{
    ; Kill PokerStars.exe
    Run, %ComSpec% /k START /wait taskkill /f /im %appName% && exit
}

GetMainLobby(appName, pokerPath)
{
    ; Wait and then restart PokerStars.exe
    Sleep, 1000
    Run, "%pokerPath%%appName%"
    ; Set focus & login
    WinTitle := "PokerStars Lobby"
    WinWait, %WinTitle%, , 10
    if ErrorLevel
        return False
    WinActivate
    ; Wait for login, then login
    if (!ControlFocusWait("PokerStarsButtonClass3",,,,, 30000))
    {
        Send {Enter}
        return !ControlFocusWait("Chrome_WidgetWin_01",,,,, 30000)
    }
    return False
}

ControlFocusWait(Control, WinTitle:="A", WinText:="", ExcludeTitle:="", ExcludeText:="", TimeOut:="") {
    StartTime := A_TickCount
    Loop, {
        ControlGetFocus, OutputControl, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
        if (OutputControl = Control)
            return 0    ;Success
        else if (TimeOut && A_TickCount - StartTime > TimeOut)
            return 1    ;Timed out
    }
}

DoubleClick()
{
    Click
    Sleep, 100
    Click
}