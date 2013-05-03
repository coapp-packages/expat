@echo off
setlocal

if "%1"=="clean" goto :clean
if "%1"=="noclean" (
	set __NOCLEAN__=true
	shift)

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" amd64
call :build x64 Release v110
call :build x64 Debug v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86
call :build Win32 Release v110
call :build Win32 Debug v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" amd64
call :build x64 Release v100
call :build x64 Debug v100
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
call :build Win32 Release v100
call :build Win32 Debug v100
endlocal

if "%__NOCLEAN__%"=="true" goto :eof
goto :clean

:build
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=DynamicLibrary /P:Wide=false expat\expat.vcxproj
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=StaticLibrary /P:Wide=false expat\expat.vcxproj
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=DynamicLibrary /P:Wide=true expat\expat.vcxproj
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=StaticLibrary /P:Wide=true expat\expat.vcxproj
REM msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 ..\expat.sln

REM md ..\output\%3\%1\%2\bin\
REM md ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpat.dll      ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\libexpatw.dll     ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\libexpat.pdb      ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\libexpatw.pdb     ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\libexpat.exp      ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpat.lib      ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpatMT.lib    ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpatw.exp     ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpatw.lib     ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\libexpatwMT.lib   ..\output\%3\%1\%2\lib\
REM copy /y ..\win32\bin\%1\%2\xmlwf.exe         ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\outline.exe       ..\output\%3\%1\%2\bin\
REM copy /y ..\win32\bin\%1\%2\elements.exe      ..\output\%3\%1\%2\bin\

goto :eof

:clean
rd /s /q expat\intermediate >nul 2>nul


