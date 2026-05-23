@echo off
title HouseApp - Build APK
echo ============================================
echo   HouseApp - APK Builder
echo ============================================
echo.

:: Check for Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java JDK 17+ is not installed.
    echo.
    echo Install it from: https://adoptium.net/temurin/releases/?version=17
    echo Or run: winget install "Eclipse Temurin JDK 17"
    echo.
    pause
    exit /b 1
)

:: Check JAVA_HOME
if "%JAVA_HOME%"=="" (
    echo [WARNING] JAVA_HOME is not set. Flutter might not find Java.
    echo Trying to proceed anyway...
    echo.
)

:: Check Flutter
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter SDK not found in PATH.
    echo Add Flutter to your PATH or run this from Flutter's bin directory.
    pause
    exit /b 1
)

echo [1/5] Getting dependencies...
call flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] flutter pub get failed.
    pause
    exit /b 1
)

echo.
echo [2/5] Analyzing code...
call flutter analyze
echo.

echo [3/5] Cleaning previous builds...
call flutter clean

echo.
echo [4/5] Building debug APK...
call flutter build apk --debug
if %errorlevel% neq 0 (
    echo [ERROR] Build failed.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   SUCCESS! APK built successfully!
echo ============================================
echo.
echo   Location: build\app\outputs\flutter-apk\app-debug.apk
echo.
echo   Next steps:
echo   1. Transfer the APK to your Android device
echo   2. Enable "Install from unknown sources"
echo   3. Install and test the app
echo.
echo   For production release:
echo   - Set up Firebase with: flutterfire configure
echo   - Add google-services.json to android/app/
echo   - Add Poppins fonts to assets/fonts/
echo   - Create a release keystore
echo   - Build with: flutter build apk --release
echo.

pause
