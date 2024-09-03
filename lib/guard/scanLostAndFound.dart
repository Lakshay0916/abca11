import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class ScanLostAndFound extends StatefulWidget {
  @override
  _ScanLostAndFoundState createState() => _ScanLostAndFoundState();
}

class _ScanLostAndFoundState extends State<ScanLostAndFound> {
  String qrCodeResult = "Not Scanned Yet";

  Future<void> startQRScan() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#7785FC', // Color of the scanning screen
        'Cancel', // Cancel button text
        true, // Enable flash
        ScanMode.QR, // Scan mode (QR code in this case)
      );

      if (!mounted) return;

      if (qrCode == "-1") {
        setState(() {
          qrCodeResult = "Scan Cancelled";
        });
        return;
      } else {
        Vibration.vibrate();

        // Attempt to decode the QR code
        try {
          final Map<String, String> decodedData = _decodeQRCode(qrCode);
          final String itemId = decodedData['item_id']!;
          final String uid = decodedData['uid']!;

          // Check if the item exists in the Firestore collection
          final itemDoc = await FirebaseFirestore.instance.collection('lostnfound').doc(itemId).get();

          if (itemDoc.exists) {
            final String status = itemDoc['Status'] ?? '';

            if (status.toLowerCase() == 'claimed') {
              // Item is already claimed
              _showInvalidQRCodeDialog('This item has already been claimed.');
            } else {
              // Item exists and is not yet claimed, update the document with claimed information and status
              await FirebaseFirestore.instance.collection('lostnfound').doc(itemId).update({
                'claimedBy': uid,
                'claimedAt': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()), // Current timestamp
                'Status': 'claimed', // Update status to claimed
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClaimSuccessPage(itemId: itemId),
                ),
              );
            }
          } else {
            // Item not found in the collection
            _showInvalidQRCodeDialog('Invalid QR Code. Item not found.');
          }
        } catch (e) {
          // Failed to decode the QR code or it doesn't have the complete data
          _showInvalidQRCodeDialog('Invalid QR Code.');
        }
      }
    } catch (e) {
      setState(() {
        qrCodeResult = 'Failed to get QR code: $e';
      });
    }
  }

  // Caesar cipher decryption function
  String _caesarCipher(String text, int shift) {
    return String.fromCharCodes(
      text.runes.map((int rune) {
        var char = String.fromCharCode(rune);
        if (char.contains(RegExp(r'[a-z]'))) {
          return ((rune - 97 - shift + 26) % 26 + 97);
        } else if (char.contains(RegExp(r'[A-Z]'))) {
          return ((rune - 65 - shift + 26) % 26 + 65);
        } else if (char.contains(RegExp(r'[0-9]'))) {
          return ((rune - 48 - shift + 10) % 10 + 48);
        } else {
          return rune;
        }
      }),
    );
  }

  // Function to decode the QR code and decrypt the contents
  Map<String, String> _decodeQRCode(String qrCode) {
    final RegExp pattern = RegExp(r'"item_id":\s*"(.*?)",\s*"uid":\s*"(.*?)"');
    final Match? match = pattern.firstMatch(qrCode);

    if (match == null || match.groupCount != 2) {
      throw Exception("Invalid QR Code");
    }

    final String decryptedItemId = _caesarCipher(match.group(1)!, 8);
    final String decryptedUid = _caesarCipher(match.group(2)!, 8);

    return {
      'item_id': decryptedItemId,
      'uid': decryptedUid,
    };
  }

  // Function to show a dialog for invalid QR code
  void _showInvalidQRCodeDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Access Denied'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: const Text("Lost & Found"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: startQRScan,
          child: const Text("Start QR Scan"),
        ),
      ),
    );
  }
}

// Example page to show the success of claim
class ClaimSuccessPage extends StatelessWidget {
  final String itemId;

  const ClaimSuccessPage({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: const Text("Lost & Found"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 200,
            ),
            Text(
              "Item Claimed.",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
