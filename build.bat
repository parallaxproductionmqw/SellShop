@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo === Java ===
java -version
echo.
echo === Maven ===
call mvn -version
echo.
echo === Building SellShop (this can take a few minutes the first time) ===
call mvn -B clean package > build-log.txt 2>&1

if errorlevel 1 (
  echo.
  echo BUILD FAILED. Open build-log.txt and look for lines starting with [ERROR].
  pause
  exit /b 1
)

for %%f in (target\SellShop-*.jar) do copy /y "%%f" SellShop.jar >nul
echo.
echo DONE. Your plugin is the file SellShop.jar in this folder.
echo Put it into the "plugins" folder of your server.
pause
