@echo off
del -f regMemInit.vh
python xlsx2vhConverter.py
if %errorlevel% neq 0 (
    echo Error: xlsx2vhConverter.py failed.
    exit /b %errorlevel%
)