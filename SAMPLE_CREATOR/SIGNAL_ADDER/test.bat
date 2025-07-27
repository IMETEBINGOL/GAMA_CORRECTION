@echo off
REM This script runs the noise_sprinkler.py script to test the noise sprinkler functionality.
REM Ensure that the Python environment is set up correctly before running this script.
REM You can run this script from the command line or double-click it in Windows Explorer.
python signal_adder.py
REM Check if the script ran successfully
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%
    exit /b %errorlevel%
)
echo Script completed successfully.
pause
REM End of script
REM This script is intended to be run in a Windows environment.