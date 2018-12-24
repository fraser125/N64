@ECHO OFF

bass -strict -benchmark .\lib\PIXEL8_Font70-64.INC >nul

FOR /D %%D IN (*) DO (
PUSHD %%D
REM ECHO %%D
FOR %%F IN (*.asm) DO (
REM ECHO %%~nF
ECHO.
REM ECHO bass -strict %%F
bass -strict -benchmark %%F
echo %%~nF.n64
ECHO 	%%F
)
move *.bin .. 1>nul 2>nul
move *.n64 .. 1>nul 2>nul
move *.z64 .. 1>nul 2>nul
POPD
)
ECHO.
FOR %%F IN (*.n64) DO (
ECHO chksum64 %%F
	chksum64 %%F 1>nul 
)
FOR %%F IN (*.z64) DO (
ECHO chksum64 %%F
	chksum64 %%F 1>nul 
)
