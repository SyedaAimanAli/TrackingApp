import 'dart:io'; // For Platform check
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth_gate.dart';

class ScannedDataScreen extends StatefulWidget {
  final String qrData;

  const ScannedDataScreen({super.key, required this.qrData});

  @override
  ScannedDataScreenState createState() => ScannedDataScreenState();
}

class ScannedDataScreenState extends State<ScannedDataScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () => _handleSignOut(),
          ),
        ],
      ),
      body: const WebView(
        initialUrl: 'https://maps.google.com/maps',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  void _handleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      _navigateToAuthGate();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-out failed: $e')),
      );
    }
  }

  void _navigateToAuthGate() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthGate()),
      (Route<dynamic> route) => false,
    );
  }
}
