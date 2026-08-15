@echo off
set "PATH=D:\Anaconda\envs\cnic;D:\Anaconda\envs\cnic\Scripts;%PATH%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-site.ps1" -Serve
