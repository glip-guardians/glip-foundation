@echo off
REM run-extract.bat — 윈도우에서 더블클릭 실행
setlocal

REM Node가 PATH에 있어야 합니다. (nvm / Node 설치 필수)
where node >nul 2>nul
if errorlevel 1 (
  echo ❌ Node.js가 설치되어 있지 않습니다. https://nodejs.org/ 에서 설치 후 다시 실행하세요.
  pause
  exit /b 1
)

node "%~dp0extract-standard-input.js"
echo.
pause
