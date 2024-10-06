import 'dart:io';
import 'package:flutter/material.dart';
import 'after_scanned.dart'; // Replace with the actual path
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  QRScannerScreenState createState() => QRScannerScreenState();
}

class QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController?.pauseCamera(); // Null-aware operator to prevent errors
    }
    qrController?.resumeCamera(); // Null-aware operator to prevent errors
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.blueAccent[800], // WhatsApp color theme
        actions: <Widget>[
          IconButton(
            icon: Icon(isFlashOn ? Icons.flash_off : Icons.flash_on),
            color: Colors.white,
            onPressed: () {
              _toggleFlash();
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blueAccent[800] ?? Colors.blueAccent,
              borderRadius: 15.0,
              borderLength: 32.0,
              borderWidth: 8.0,
              cutOutSize: 300.0,
              overlayColor: Colors.black.withOpacity(0.5),
            ),
          ),
          const Positioned(
            bottom: 40,
            child: Text(
              'Scan QR Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        qrController?.pauseCamera(); // Ensure the camera is paused safely
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScannedDataScreen(qrData: scanData.code!),
          ),
        );
      }
    });
  }

  void _toggleFlash() async {
    if (qrController != null) {
      await qrController?.toggleFlash(); // Toggle the flash safely
      bool? flashStatus = await qrController?.getFlashStatus();
      setState(() {
        isFlashOn =
            flashStatus ?? false; // Default to false if flashStatus is null
      });
    }
  }

  @override
  void dispose() {
    qrController?.dispose(); // Ensure the controller is disposed safely
    super.dispose();
  }
}
