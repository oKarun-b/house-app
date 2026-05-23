# HouseApp - Setup & Build Guide

## Prerequisites

1. **Java JDK 17+**
   ```powershell
   winget install "Eclipse Temurin JDK 17" --accept-package-agreements
   ```

2. **Flutter SDK** (already installed at `C:\Users\PC\.cursor\sdk download\flutter`)

3. **Android SDK** (already installed at `C:\Users\PC\AppData\Local\Android\Sdk`)

4. **Firebase Account** (free tier)
   - Go to https://console.firebase.google.com
   - Create a new project
   - Register Android app with package name `com.houseapp`
   - Download `google-services.json` and place it in `android/app/`

5. **Poppins Fonts** (optional, app falls back to system font)
   - Download from https://fonts.google.com/specimen/Poppins
   - Place .ttf files in `assets/fonts/`:
     - Poppins-Light.ttf (weight 300)
     - Poppins-Regular.ttf (weight 400)
     - Poppins-Medium.ttf (weight 500)
     - Poppins-SemiBold.ttf (weight 600)
     - Poppins-Bold.ttf (weight 700)

## One-Click Build

Double-click `build_app.bat` or run:

```powershell
cd "C:\Users\PC\house app"
.\build_app.bat
```

## Manual Build

```powershell
cd "C:\Users\PC\house app"
flutter pub get
flutter analyze
flutter build apk --debug
```

## APK Location

After building, the APK is at:
```
build\app\outputs\flutter-apk\app-debug.apk
```

## Install on Device

1. Copy the APK to your Android phone
2. Enable "Install from unknown sources" in Settings
3. Tap the APK to install

## For Production Release

```powershell
# 1. Configure Firebase
flutterfire configure

# 2. Create a keystore
keytool -genkey -v -keystore android/app/houseapp-release.keystore `
  -alias houseapp -keyalg RSA -keysize 2048 -validity 10000

# 3. Set environment variables
$env:ANDROID_STORE_PASSWORD = "your_password"
$env:ANDROID_KEY_ALIAS = "houseapp"
$env:ANDROID_KEY_PASSWORD = "your_password"

# 4. Build release APK
flutter build apk --release
```

## App Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Onboarding | `/` (initial) | 3-page intro carousel |
| Auth | `/auth` | Role selection, phone OTP |
| Home | `/home` | Property feed, filters |
| Explore | `/explore` | Search, map, advanced filters |
| Favorites | `/favorites` | Saved properties, grid/list |
| Messages | `/messages` | Chat list, real-time messaging |
| Profile | `/profile` | Settings, subscription, stats |
| Payment | `/payment` | MTN/Orange Money subscription |
| Admin | `/admin` | Analytics, listing moderation |
| Add Property | `/add-property` | Landlord listing form |
| Compare | `/compare` | Side-by-side property comparison |
| Analytics | `/analytics` | Listing performance metrics |

## Tech Stack

- **Frontend**: Flutter 3.x, Material 3
- **Backend**: Firebase (Auth, Firestore, Storage, Messaging)
- **Auth**: Phone + OTP via Firebase Auth
- **Payments**: MTN Mobile Money, Orange Money (integration required)
- **Language**: English + French (localization ready)
