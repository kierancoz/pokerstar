@echo off

set ahk_compiler="Z:\Game Storage\code\autohotkey\Compiler\Ahk2Exe.exe"
set bin_path=..\pokerstar-control\bin\

%ahk_compiler% /in getGameInfo.ahk /out %bin_path%getGameInfo.exe
pyinstaller main.py --onefile --name MainRun --specpath build\ --distpath %bin_path%

echo Build Exit Code: %errorlevel%