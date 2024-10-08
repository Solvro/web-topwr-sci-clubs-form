# ToPWR SciClubs form


![KN Solvro banner](https://github.com/Solvro/script-topwr-science-clubs/assets/28555148/822d27f0-93e0-44f8-9004-f37577a93d9a)

Web form with live preview (ToPWR mock app) for submiting or changing information about your Scientific Club / Student Organization / Student Media / Cultural Agenda. Made to gather information for [ToPWR mobile app](https://github.com/Solvro/mobile-topwr), comprehensive tour guide over Wroclaw University of Science and Technology (WUST).

# See also
- ToPWR mobile flutter application: https://github.com/Solvro/mobile-topwr
- ToPWR sci clubs/orgs scraper and scripts: https://github.com/Solvro/script-topwr-science-clubs

# Developement
This is Flutter project, at the moments works only in the web version (best with html renderer destination)

1. You need working Firebase project with Firestore, Storage and Auth
- install firebase cli and run `flutterfire configure` to generate `firebase_options.dart`. You need to choose only `web` target.
https://firebase.google.com/docs/web/setup

2. Set up CORS in cloud storage
```bash
gcloud storage buckets update gs://example_bucket --cors-file=firebase_cors.json
```
https://cloud.google.com/storage/docs/cors-configurations

2. You need to run code generation with 
```bash
dart run build_runner build -d
```

3. Run the project for web
```bash
flutter run -d chrome --web-renderer html
```


# Caprover deploy
so i can remember it as well :)
if you don't know what caprover is: https://caprover.com/
```bash
flutter build web --web-renderer html
tar -cvf ./deploy.tar ./captain-definition ./build/web/*
caprover deploy -t ./deploy.tar
```
OR 
use reade made make command:
```bash
make captain-deploy  // without fvm
make fvm-captain-deploy // for fvm usage
```