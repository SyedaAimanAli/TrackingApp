import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'qr_scan.dart'; // Import your QR scanner screen

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
                child: Text("An error occurred, please try again later.")),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            body: Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blueAccent,
                  primary: Colors.blueAccent, // Use this for primary color
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent, // Text button color
                  ),
                ),
              ),
              child: SignInScreen(
                providers: [
                  EmailAuthProvider(),
                  GoogleProvider(
                    clientId:
                        "225840976436-b8f7g0629fbd61a89rigc4u1j18hk6t9.apps.googleusercontent.com",
                  ),
                ],
                actions: [
                  AuthStateChangeAction<SignedIn>((context, state) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const QRScannerScreen(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }

        return const QRScannerScreen();
      },
    );
  }
}
