@echo off
setlocal ENABLEDELAYEDEXPANSION

REM -----------------------------------------------
REM python-switch.bat  —  switch default Python on Windows (user PATH)
REM Usage:
REM   python-switch list
REM   python-switch use <PYTHON_ROOT> [--py]
REM   python-switch use27        [--py]
REM   python-switch use313       [--py]
REM   python-switch use312       [--py]
REM -----------------------------------------------

if "%~1"=="" goto :help

set ACTION=%~1
set FLAG_PY=0
if /I "%~3"=="--py" set FLAG_PY=1

if /I "%ACTION%"=="list"  goto :list
if /I "%ACTION%"=="use"   goto :use

if /I "%ACTION%"=="use27"  (
  set "TARGET=C:\Python27"
  goto :use
)
if /I "%ACTION%"=="use313" (
  set "TARGET=%LocalAppData%\Programs\Python\Python313"
  goto :use
)
if /I "%ACTION%"=="use312" (
  set "TARGET=%LocalAppData%\Programs\Python\Python312"
  goto :use
)

:use
if not defined TARGET set "TARGET=%~2"
if "%TARGET%"=="" (
  echo [ERROR] Missing target. Example: python-switch use C:\Python27 [--py]
  exit /b 1
)

if not exist "%TARGET%\python.exe" (
  echo [ERROR] Not found: "%TARGET%\python.exe"
  exit /b 2
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$u=[Environment]::GetEnvironmentVariable('Path','User') -split ';' | ? { $_ -and $_.Trim() -ne '' };" ^
  "$add=@('%TARGET%','%TARGET%\Scripts');" ^
  "$merged=@($add + ($u | ? { $_ -notin $add }));" ^
  "[Environment]::SetEnvironmentVariable('Path',($merged -join ';'),'User');" ^
  "Write-Host 'User PATH updated.';" ^
  "Write-Host 'First entries:'; $merged[0..([Math]::Min(4,$merged.Count-1))] | ForEach-Object { '  - ' + $_ }"

if %FLAG_PY%==1 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$exe = Join-Path '%TARGET%' 'python.exe';" ^
    "if (-not (Test-Path $exe)) { Write-Error 'python.exe not found'; exit 1 }" ^
    "$ver = (& $exe --version) -replace '^Python\s+','';" ^
    "$majMin = ($ver -split '\.')[0..1] -join '.';" ^
    "$ini = Join-Path $env:LOCALAPPDATA 'py.ini';" ^
    "Set-Content -Encoding Ascii -Path $ini -Value \"[defaults]`npython=$majMin\";" ^
    "Write-Host ('py launcher default set to ' + $majMin + ' in ' + $ini)"
)

echo.
echo Switched default "python" to: "%TARGET%\python.exe"
echo Open a NEW terminal, then run:  python --version
exit /b 0

:list
echo === Detected by PATH / Launcher ===
where python 2>nul
where py 2>nul
echo.
echo === Python Launcher (py) table ===
py -0p 2>nul
echo.
echo === Common install folders (if present) ===
if exist "C:\Python27\python.exe" echo C:\Python27\python.exe
if exist "%LocalAppData%\Programs\Python\Python313\python.exe" echo %LocalAppData%\Programs\Python\Python313\python.exe
if exist "%LocalAppData%\Programs\Python\Python312\python.exe" echo %LocalAppData%\Programs\Python\Python312\python.exe
echo.
exit /b 0

:help
echo Usage:
echo   python-switch list
echo   python-switch use ^<PYTHON_ROOT^> [--py]
echo   python-switch use27        [--py]
echo   python-switch use313       [--py]
echo   python-switch use312       [--py]
echo.
echo Examples:
echo   python-switch use C:\Python27 --py
echo   python-switch use "%LocalAppData%\Programs\Python\Python313" --py
echo.
echo Tip: Turn OFF Windows "App execution aliases" for python.exe/python3.exe.
exit /b 0
