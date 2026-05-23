param(
    [switch]$Release,
    [string]$OutputDir = "build\app\outputs\flutter-apk"
)

$ErrorActionPreference = "Stop"
$scriptPath = Split-Path -Parent $PSCommandPath
$APK_PATH = Join-Path $scriptPath $OutputDir

Write-Host "============================================" -ForegroundColor Green
Write-Host "   HouseApp - APK Builder for Windows" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# ---- Step 1: Detect JDK ----
Write-Host "[1/6] Checking Java JDK 17+..." -ForegroundColor Cyan

$javaFound = $false
$javaCandidates = @(
    $env:JAVA_HOME
    "C:\Program Files\Java\jdk-17*",
    "C:\Program Files\Java\jdk-21*",
    "C:\Program Files\Eclipse Adoptium\*",
    "C:\Program Files\Microsoft\jdk-*",
    "C:\Program Files\BellSoft\*"
)

foreach ($pattern in $javaCandidates) {
    $paths = Get-ChildItem $pattern -ErrorAction SilentlyContinue
    foreach ($p in $paths) {
        $javaExe = Join-Path $p.FullName "bin\java.exe"
        if (Test-Path $javaExe) {
            $env:JAVA_HOME = $p.FullName
            $env:Path = "$(Join-Path $p.FullName 'bin');$env:Path"
            $javaFound = $true
            $version = & $javaExe -version 2>&1
            Write-Host "  Found: $($p.FullName)" -ForegroundColor Green
            Write-Host "  $($version[0])" -ForegroundColor Gray
            break
        }
    }
    if ($javaFound) { break }
}

if (-not $javaFound) {
    Write-Host "  [ERROR] Java JDK 17+ not found." -ForegroundColor Red
    Write-Host "  Install from: https://adoptium.net/temurin/releases/?version=17" -ForegroundColor Yellow
    Write-Host "  Or run: winget install 'Eclipse Temurin JDK 17'" -ForegroundColor Yellow
    exit 1
}

# ---- Step 2: Check Flutter ----
Write-Host "[2/6] Checking Flutter SDK..." -ForegroundColor Cyan
$flutter = Get-Command "flutter" -ErrorAction SilentlyContinue
if (-not $flutter) {
    $flutterPath = "C:\Users\PC\.cursor\sdk download\flutter\bin\flutter.bat"
    if (Test-Path $flutterPath) {
        $script:flutter = $flutterPath
    } else {
        Write-Host "  [ERROR] Flutter not found. Add Flutter to PATH." -ForegroundColor Red
        exit 1
    }
}
Write-Host "  Flutter found." -ForegroundColor Green

# ---- Step 3: Verify Android SDK ----
Write-Host "[3/6] Verifying Android SDK..." -ForegroundColor Cyan
$sdkPath = "C:\Users\PC\AppData\Local\Android\Sdk"
if (-not (Test-Path $sdkPath)) {
    Write-Host "  [ERROR] Android SDK not found at $sdkPath" -ForegroundColor Red
    exit 1
}
$env:ANDROID_SDK_ROOT = $sdkPath
$env:ANDROID_HOME = $sdkPath
Write-Host "  SDK found at $sdkPath" -ForegroundColor Green

# ---- Step 4: Get Dependencies ----
Write-Host "[4/6] Installing Flutter dependencies..." -ForegroundColor Cyan
Push-Location $scriptPath
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }
    Write-Host "  Dependencies installed." -ForegroundColor Green
} catch {
    Write-Host "  [ERROR] $_" -ForegroundColor Red
    exit 1
}

# ---- Step 5: Code Analysis ----
Write-Host "[5/6] Running code analysis..." -ForegroundColor Cyan
flutter analyze
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [WARNING] Analysis found issues (non-blocking)" -ForegroundColor Yellow
} else {
    Write-Host "  Analysis passed." -ForegroundColor Green
}

# ---- Step 6: Build APK ----
if ($Release) {
    Write-Host "[6/6] Building RELEASE APK..." -ForegroundColor Cyan
    flutter build apk --release
} else {
    Write-Host "[6/6] Building DEBUG APK..." -ForegroundColor Cyan
    flutter build apk --debug
}

if ($LASTEXITCODE -eq 0) {
    $apkFile = if ($Release) { "app-release.apk" } else { "app-debug.apk" }
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Green
    Write-Host "   BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  APK: $APK_PATH\$apkFile" -ForegroundColor White
    Write-Host "  Size: $([math]::Round((Get-Item (Join-Path $APK_PATH $apkFile)).Length / 1MB, 1)) MB" -ForegroundColor White
    Write-Host ""
    Write-Host "  Install on Android device:" -ForegroundColor Yellow
    Write-Host "  1. Copy the APK to your phone" -ForegroundColor Gray
    Write-Host "  2. Enable 'Install from unknown sources'" -ForegroundColor Gray
    Write-Host "  3. Open the APK file to install" -ForegroundColor Gray
} else {
    Write-Host "[ERROR] Build failed." -ForegroundColor Red
}

Pop-Location
