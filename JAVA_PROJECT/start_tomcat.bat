@echo off
setlocal
echo ========================================================
echo Starting Apache Tomcat 11 for ShopSphere...
echo ========================================================

rem Auto-detect WAR file location
set "WAR_FILE="
if exist "%~dp0ShopSphere\target\ShopSphere.war" (
    set "WAR_FILE=%~dp0ShopSphere\target\ShopSphere.war"
) else if exist "%~dp0JAVA_PROJECT\ShopSphere\target\ShopSphere.war" (
    set "WAR_FILE=%~dp0JAVA_PROJECT\ShopSphere\target\ShopSphere.war"
)

rem Auto-detect Tomcat directory
set "TOMCAT_DIR="
if exist "%USERPROFILE%\Downloads\apache-tomcat-11.0.26\apache-tomcat-11.0.26\bin\startup.bat" (
    set "TOMCAT_DIR=%USERPROFILE%\Downloads\apache-tomcat-11.0.26\apache-tomcat-11.0.26"
) else if exist "C:\Users\HP\Downloads\apache-tomcat-11.0.26\apache-tomcat-11.0.26\bin\startup.bat" (
    set "TOMCAT_DIR=C:\Users\HP\Downloads\apache-tomcat-11.0.26\apache-tomcat-11.0.26"
) else if exist "%USERPROFILE%\Downloads\apache-tomcat-11.0.26\bin\startup.bat" (
    set "TOMCAT_DIR=%USERPROFILE%\Downloads\apache-tomcat-11.0.26"
)

if "%TOMCAT_DIR%"=="" (
    echo [ERROR] Could not find Tomcat installation directory!
    pause
    exit /b 1
)

echo Tomcat Directory: %TOMCAT_DIR%

if not "%WAR_FILE%"=="" (
    echo Deploying latest ShopSphere.war to Tomcat webapps...
    copy /Y "%WAR_FILE%" "%TOMCAT_DIR%\webapps\"
)

if "%JAVA_HOME%"=="" (
    set "JAVA_HOME=C:\Program Files\Java\jdk-17"
)

echo.
echo Launching Tomcat Server...
echo Once Tomcat starts, open: http://localhost:8080/ShopSphere/
echo.

cd /d "%TOMCAT_DIR%\bin"
set "CATALINA_HOME=%TOMCAT_DIR%"
set "CATALINA_BASE=%TOMCAT_DIR%"
start "Apache Tomcat 11 - ShopSphere" cmd.exe /k "catalina.bat run"

echo Tomcat window opened!
