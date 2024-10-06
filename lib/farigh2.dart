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
        if (!snapshot.hasData) {
          return Scaffold(
            // Remove the AppBar by not including it in the Scaffold
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SignInScreen(
                    providers: [
                      EmailAuthProvider(),
                      GoogleProvider(
                        clientId:
                            "225840976436-15d59vkpdot271o0q7sobtjd3j1mnvb3.apps.googleusercontent.com",
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
                    // Remove header and footer to avoid extra space
                    headerBuilder: (context, constraints, shrinkOffset) {
                      return const SizedBox.shrink();
                    },
                    footerBuilder: (context, action) {
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          );
        }

        return const QRScannerScreen();
      },
    );
  }
}
































// import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
// import 'package:flutter/material.dart';
// import 'qr_scan.dart'; // Import your QR scanner screen

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Scaffold(
//             // Remove the AppBar by not including it in the Scaffold
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: SignInScreen(
//                     providers: [
//                       EmailAuthProvider(),
//                       GoogleProvider(
//                         clientId:
//                             "225840976436-15d59vkpdot271o0q7sobtjd3j1mnvb3.apps.googleusercontent.com",
//                       ),
//                     ],
//                     actions: [
//                       AuthStateChangeAction<SignedIn>((context, state) {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                             builder: (context) => const QRScannerScreen(),
//                           ),
//                         );
//                       }),
//                     ],
//                     // Remove header and footer to avoid extra space
//                     headerBuilder: (context, constraints, shrinkOffset) {
//                       return const SizedBox.shrink();
//                     },
//                     footerBuilder: (context, action) {
//                       return const SizedBox
//                           .shrink(); // Hides the footer including the register link
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }

//         return const QRScannerScreen();
//       },
//     );
//   }
// }
