import 'package:cpd/screens/home_screen.dart';
import 'package:cpd/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*
TODO: Set iOS min version via Podfile - https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#2
TODO: Add location and camera permissions for iOS
TODO: Add iOS app to Firebase
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Get an instance of the Firebase Initialisation
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CPD App",

      // Create the app theme
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: const TextTheme(
          headline1: TextStyle(),
          headline2: TextStyle(),
          headline3: TextStyle(),
          headline4: TextStyle(),
          headline5: TextStyle(),
          headline6: TextStyle(),
          subtitle1: TextStyle(),
          subtitle2: TextStyle(),
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.indigo,
          displayColor: Colors.indigo,
        ),
      ),

      // Check if the Firebase Core functionalities are initialised
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // If any, show errors
          if (snapshot.hasError) {
            return Container(
              color: Theme.of(context).cardColor,
              child: Center(
                child: Text(
                  "An error occurred: ${snapshot.error}",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Check if the user is not signed in.
          // If this is the case, show the Welcome Screen
          // Otherwise, show the home page
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAuth.instance.currentUser == null
                ? const WelcomeScreen()
                : const HomeScreen();
          }

          // Show a loading indicator while the Firebase Core services are loading
          return Container(
            color: Theme.of(context).cardColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
