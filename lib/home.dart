import 'dart:io';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  String? qrText;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController?.pauseCamera();
    }
    qrController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            alignment: Alignment.center,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    // actions: [
                    //   SignedOutAction((context) {
                    //     Navigator.of(context).pop();
                    //   })
                    // ],
                    // children: [
                    // const Divider(),
                    // Padding(
                    //   padding: const EdgeInsets.all(2),
                    //   child: AspectRatio(
                    //     aspectRatio: 1,
                    //     child: Image.asset('flutterfire_300x.png'),
                    //   ),
                    // ),
                    // ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SignOutButton(),
            const SizedBox(height: 20),
            // QR Code Scanner Button
            ElevatedButton.icon(
              onPressed: () => _showQRScanner(context),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR Code'),
              // iconAlignment: IconAlignment.end,
            ),
            // Display QR Code Scanning Result
            if (qrText != null) ...[
              const SizedBox(height: 20),
              Text(
                'Scanned QR Code: $qrText',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }

  void _showQRScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: 300,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 200,
            ),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
      });
      Navigator.pop(context); // Close the dialog once a QR code is scanned
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
