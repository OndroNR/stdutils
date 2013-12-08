Caption "StdUtils Test-Suite"

!addincludedir  "..\..\Include"

!ifdef NSIS_UNICODE
	!addplugindir "..\..\Plugins\Release_Unicode"
	OutFile "ShellExecWaitWithExitCode-Unicode.exe"
!else
	!addplugindir "..\..\Plugins\Release_ANSI"
	OutFile "ShellExecWaitWithExitCode-ANSI.exe"
!endif

!include 'StdUtils.nsh'

RequestExecutionLevel user
ShowInstDetails show

Section
	DetailPrint 'ExecShellWait: "$SYSDIR\mspaint.exe"'
	Sleep 1000
	${StdUtils.ExecShellWaitEx} $0 $1 "$SYSDIR\mspaint.exe" "open" "" ;try to launch the process
	DetailPrint "Result: $0" ;returns process handle. Might be "no_wait". Failure indicated by "error".
	StrCmp $0 "error" WaitFailed ;check if process failed to create.
	StrCmp $0 "no_wait" WaitNotPossible ;check if process can be waited for. Always check this!
	
	DetailPrint "Waiting for process. ZZZzzzZZZzzz..."
	${StdUtils.WaitForProcEx} $1 $0
	StrCmp $1 "error" ExitCodeFailed
	DetailPrint "Process just terminated with exit code: $1"
	Goto WaitDone
	
	WaitFailed:
	;Pop $0
	;${StdUtils.GetLastError} $1
	DetailPrint "Failed to create process, error code: $1"
	Goto WaitDone

	WaitNotPossible:
	DetailPrint "Can not wait for process."
	Goto WaitDone
	
	ExitCodeFailed:
	DetailPrint "Failed to wait for process (exit code not available)"
	Goto WaitDone
	
	WaitDone:
SectionEnd
