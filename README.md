# SquirrelWatch

> NOTE: The squirrel feeder repository is part of the SoSe25 at the University of Applied Sciences of Bremen. Any duplication or publication of the code is strictly forbidden.

**SquirrelFeeder** - the _last_ feeder your ever going to need!

This repository contains the source code for both the frontend and firmware or the SquirrelWatch automated squirrel feeder IoT system.
It also contains setup and dependency instructions.

## Dependencies

Frontend:
- Flutter
- Android SDK (if the app shall be run as an `.apk`)

Backend:
- Arduino IDE
- ESP32-WROOM-32

> NOTE: The blueprints, other hardwareparts and build instructions are only available upon request from pilkiad+squirrelwatch@proton.me for licensing reasons. The ESP mentioned above is the microcontroller powering the feeder.

## Installation

Frontend:
1. [Install all frontend dependencies](#dependencies)
2. Navigate to `frontend/`
3. Run `flutter pub get` to install all flutter dependencies
4. Run `flutter run` to build and run the application
    1. If you execute the commant normally, it will build the application for your device natively
    2. If you have an android phone with android debug bridge (ABD) enabled flutter will automatically build the application for your phone. [Click here to open the official ADB help site!](https://developer.android.com/tools/adb)

Backend:
1. [Install all backend dependencies](#dependencies)
2. Compile and upload the included `main.c` to your connected ESP using the Arduino IDE

## Structure

| Directory / File | Explanation |
| --- | --- |
| frontend | The flutter application, runs on Windows, MacOS, Linux, iOS and Android |
| firmware | |
| README | This file! |
