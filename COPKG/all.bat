@echo off
setlocal

if "%1"=="clean" goto :cleanall
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

goto :eof

:build
REM msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=DynamicLibrary /P:CallingConvention=cdecl .\zlib.vcxproj
REM msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=StaticLibrary /P:CallingConvention=cdecl .\zlib.vcxproj
REM msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=DynamicLibrary /P:CallingConvention=stdcall .\zlib.vcxproj
REM msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=StaticLibrary /P:CallingConvention=stdcall .\zlib.vcxproj
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 ..\expat.sln

md ..\output\%3\%1\%2\bin\
md ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpat.dll      ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\libexpatw.dll     ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\libexpat.pdb      ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\libexpatw.pdb     ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\libexpat.exp      ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpat.lib      ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpatMT.lib    ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpatw.exp     ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpatw.lib     ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\libexpatwMT.lib   ..\output\%3\%1\%2\lib\
copy /y ..\win32\bin\%1\%2\xmlwf.exe         ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\outline.exe       ..\output\%3\%1\%2\bin\
copy /y ..\win32\bin\%1\%2\elements.exe      ..\output\%3\%1\%2\bin\

if "__NOCLEAN__"=="true" goto :eof

:clean
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /T:Clean ..\expat.sln
rd /s /q ..\win32\bin >nul 2>nul
rd /s /q ..\win32\tmp >nul 2>nul

goto :eof

:cleanall
setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" amd64
call :clean x64 Release v110
call :clean x64 Debug v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86
call :clean Win32 Release v110
call :clean Win32 Debug v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" amd64
call :clean x64 Release v100
call :clean x64 Debug v100
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
call :clean Win32 Release v100
call :clean Win32 Debug v100
endlocal

