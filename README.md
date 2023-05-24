# Minimal authentication flow with Flutter & Firebase Auth

A simple Flutter app showing how to authenticate with the [Firebase UI Auth](https://pub.dev/packages/firebase_ui_auth) package:

![Simple auth flow](/.github/images/simple-auth-flow.png)

## Setup

- Create a Firebase project from [the console](https://console.firebase.google.com/)
- clone this repo
- run `flutterfire configure --project=your-firebase-project-id`

Once this is done, you should be able to run the app on iOS, Android, and web, but **not on macOS**.

## MacOS setup

To get the app to work on macOS, follow the steps on this guide:

- [Flutter & Firebase Auth: How to Get it Working on macOS](https://codewithandrea.com/articles/flutter-firebase-auth-macos/)

You can grab the completed code too:

```
git checkout macos-project-fixes
```

### [LICENSE: MIT](LICENSE.md)