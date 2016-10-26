@echo off

REM setup the PATH and GOPATH
set GOPATH=%cd%
set OLDPATH=%PATH%
set PATH=%PATH%;%cd%\bin

REM reset the GOOS and GOARCH environment variables
set GOOS=
set GOARCH=

REM install GB if we don't have it yet
go get github.com/constabulary/gb/...

REM build windows
call :build windows amd64
call :build windows 386

REM build linux
call :build linux amd64
call :build linux 386

call :build freebsd amd64
call :build freebsd 386

REM remove the log
del build.log

REM restore the PATH
set PATH=%OLDPATH%

REM exit here to prevent the build function from running
goto :EOF

:build
set GOOS=%1%
set GOARCH=%2%
echo Building %GOOS%-%GOARCH%

gb build dnd > build.log 2>&1

if errorlevel 1 (
    echo ERROR
    type build.log
) else (
    echo SUCCESS
)
echo.
exit /B 1
