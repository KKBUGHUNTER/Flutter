# Android SDK Setup on Windows for Flutter (Without Android Studio)

## 📁 Directory Structure

Create the following directory:
```text
C:\dev\Android
├── platform-tools
│ └── adb.exe, etc.
└── cmdline-tools
  └── latest
    ├── bin
    ├── lib
    ├── NOTICE.txt
    └── source.properties
```
---
## 📥 Step 1: Download Required Tools
- Download **Command Line Tools (Windows)** from:
https://developer.android.com/studio
- Download **Platform Tools (Windows)** from:
https://developer.android.com/tools/releases/platform-tools
---
## 📦 Step 2: Extract Files
1. Extract the ZIP into:
```text
C:\dev\Android\
```
both in the same `dir` <br>
`Note:` you want to update the folder structure of the commandline-tools add latest folder into and move all the files and folder to the latest folder.

3. Move all extracted files (like `bin`, `lib`, etc.) into `latest`
---
## ⚙️ Step 3: Set Environment Variables
### 1. Add System Variable:
| Variable Name | Value                |
|---------------|----------------------|
| ANDROID_HOME  | C:\dev\Android       |
### 2. Add to `Path` (System Variables):
Add the following entries:
```text
C:\dev\Android\cmdline-tools\latest\bin
C:\dev\Android\platform-tools
```
---
## 🔧 Step 4: Install Required Packages
Open Command Prompt and run:
```bash
sdkmanager --sdk_root=C:\dev\Android "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```
Then accept licenses:
```bash
sdkmanager --licenses
```

# ✅ Step 5: Verify with Flutter
Run:
```bash
flutter doctor
flutter doctor --android-licenses
```
You should see no Android SDK errors.

# 🛠 Step 6: Build APK
From your Flutter project directory:
```bash
flutter build apk
```
Done!


























































