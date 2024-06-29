# topwr_sci_clubs_form

A new Flutter project.

# Developement
This is Flutter project, at the moments works only in the web version (best with html renderer destination)

1. You need working Firebase project with Storage, Firestore i Auth
- install firebase cli and run `flutterfire configure` to generate `firebase_options.dart`. You need to choose only `web` target.
https://firebase.google.com/docs/web/setup

2. You need to run code generation with 
```bash
dart run build_runner build -d
```

3. Run the project for web
```bash
flutter run -d chrome --web-renderer html
```

