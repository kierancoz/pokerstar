@echo off

:: REQUIRED INPUTS TO BUILD CORRECTLY
set ahk_compiler="Z:\app_installs\thirdparty\autohotkey\Compiler\Ahk2Exe.exe"
set build_path=Z:\app_installs\temp\pokerstar
set tesseract_path=Z:\app_installs\thirdparty\Tesseract-OCR
:: REPO drive
Z:
:: END REQUIRED INPUTS

set bin_path=%build_path%\bin\
IF not exist %bin_path% ( mkdir %bin_path% )
IF not exist %build_path%\images ( mkdir %build_path%\images )
IF not exist %build_path%\tp ( 
    mkdir %build_path%\tp
    mkdir %build_path%\tp\Tesseract-OCR
    Xcopy /E /I %tesseract_path% %build_path%\tp\Tesseract-OCR
)

%ahk_compiler% /in getGameInfo.ahk /out %bin_path%\getGameInfo.exe
pyinstaller main.py --onefile --name GameInfoControl --specpath build\ --distpath %bin_path%

echo Build Exit Code: %errorlevel%