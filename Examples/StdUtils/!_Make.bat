@echo off
REM ----------------------------------------------------------------------
set "NSIS_ANSI=D:\NSIS"
set "NSIS_Unicode=D:\NSIS\_Unicode"
REM ----------------------------------------------------------------------
set "NSIS_PROJECTS=StdUtilsTest,ShellExecAsUser,InvokeShellVerb,ShellExecWait,ShellExecWaitWithExitCode,GetParameters"
REM ----------------------------------------------------------------------
REM
for %%i in (%NSIS_PROJECTS%) do (
	del "%~dp0\%%i-ANSI.exe"
	del "%~dp0\%%i-Unicode.exe"
	if exist "%~dp0\%%i-ANSI.exe" (
		pause
		exit
	)
	if exist "%~dp0\%%i-Unicode.exe" (
		pause
		exit
	)
)
REM ----------------------------------------------------------------------
for %%i in (%NSIS_PROJECTS%) do (
	"%NSIS_ANSI%\makensis.exe" "%~dp0\%%i.nsi"
	"%NSIS_Unicode%\makensis.exe" "%~dp0\%%i.nsi"
)
REM ----------------------------------------------------------------------
pause
