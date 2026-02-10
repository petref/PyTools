@echo off
setlocal

REM --------------------------------------------
REM  create-venv311.bat
REM  Usage:
REM     create-venv311 <env_name>
REM
REM  Example:
REM     create-venv311 myenv
REM --------------------------------------------

if "%~1"=="" (
    echo [ERROR] Missing environment name.
    echo Usage: create-venv311 ^<env_name^>
    exit /b 1
)

set "ENVNAME=%~1"

echo [*] Checking for Python 3.11 ...
py -3.11 --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python 3.11 not found. Aborting.
    exit /b 1
)

echo [*] Creating virtual environment "%ENVNAME%" ...
py -3.11 -m venv "%ENVNAME%"
if errorlevel 1 (
    echo [ERROR] Failed to create virtual environment.
    exit /b 1
)

echo [*] Activating environment "%ENVNAME%" ...
call "%ENVNAME%\Scripts\activate.bat"

echo [*] Upgrading pip ...
python -m pip install --upgrade pip

echo [*] Installing Jupyter ...
pip install jupyter

echo.
echo [*] Environment "%ENVNAME%" ready!
echo --------------------------------------------
python --version
pip --version
echo --------------------------------------------
echo To activate it later, run:
echo     call %ENVNAME%\Scripts\activate.bat
echo --------------------------------------------
echo Launch Jupyter Notebook with:
echo     jupyter notebook
echo --------------------------------------------
pause
