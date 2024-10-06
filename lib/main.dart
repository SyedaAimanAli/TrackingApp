import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this file contains Firebase options
import 'auth_gate.dart'; // Import your AuthGate widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options provided in firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking App', // Add a title for your app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Main theme color
        brightness: Brightness.light, // Light mode
        appBarTheme: const AppBarTheme(
          color: Colors.blue, // AppBar color
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blueAccent, // Button color
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark mode
        // primarySwatch: const Color.fromARGB(255, 29, 124, 248),
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blueAccent,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      themeMode: ThemeMode.system, // Use system theme mode
      home: const AuthGate(), // Set AuthGate as the root widget
      // Consider adding onGenerateRoute or onUnknownRoute if you have dynamic routes
      // onGenerateRoute: (RouteSettings settings) {
      //   // Define route generation logic here
      // },
      // onUnknownRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(builder: (context) => ErrorPage());
      // },
    );
  }
}
