@echo off
setlocal

rem CuteDiscordPresence - Qt Creator 20.0.2 / Qt 6.11.2 / MSVC x64
rem Run this from an "x64 Native Tools Command Prompt for VS 2022".

if not defined QTC_DIR set "QTC_DIR=C:\Qt\Tools\QtCreator"
if not defined QT_DIR set "QT_DIR=C:\Qt\6.11.2\msvc2022_64"

if not exist "%QTC_DIR%\bin\qtcreator.exe" (
  echo [ERROR] Qt Creator not found at: %QTC_DIR%
  echo Set QTC_DIR to your Qt Creator 20.0.2 directory and run again.
  exit /b 1
)
if not exist "%QT_DIR%\bin\qmake.exe" if not exist "%QT_DIR%\bin\qtpaths.exe" (
  echo [ERROR] Qt 6.11.2 MSVC not found at: %QT_DIR%
  echo Set QT_DIR to the Qt build used by Qt Creator and run again.
  exit /b 1
)

where cmake >nul 2>nul || (echo [ERROR] cmake not found in PATH & exit /b 1)
where ninja >nul 2>nul || (echo [ERROR] ninja not found in PATH & exit /b 1)
where cl >nul 2>nul || (echo [ERROR] MSVC cl.exe not found. Use x64 Native Tools Command Prompt for VS 2022. & exit /b 1)

rmdir /s /q build 2>nul
mkdir build

cmake -S . -B build -G Ninja ^
  -DCMAKE_BUILD_TYPE=Release ^
  -Dqt_dir="%QT_DIR%" ^
  -Dqtc_dir="%QTC_DIR%" ^
  -DCMAKE_PREFIX_PATH="%QT_DIR%;%QTC_DIR%"
if errorlevel 1 goto :fail

cmake --build build --config Release
if errorlevel 1 goto :fail

echo.
echo [OK] Build completed.
echo Search the build directory for CuteDiscordPresence.dll or the generated plugin archive.
echo For testing you can start Qt Creator with: qtcreator.exe -pluginpath ^<build-plugin-dir^>
exit /b 0

:fail
echo.
echo [ERROR] Build failed. Copy the complete error output and send it back here.
exit /b 1
