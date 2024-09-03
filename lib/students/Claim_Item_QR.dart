import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class ClaimItemQR extends StatelessWidget {
  final String id; // The ID of the lost and found item

  const ClaimItemQR({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    // Encrypt the data
    final String encryptedId = _caesarCipher(id, 8);
    final String encryptedUid = _caesarCipher(firebaseUser.uid, 8);

    // Create a JSON object
    final Map<String, String> qrData = {
      "item_id": encryptedId,
      "uid": encryptedUid,
    };

    // Convert JSON object to string
    final String qrDataString = jsonEncode(qrData);

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
            color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: qrDataString,
                version: QrVersions.auto,
                size: width * 0.7,
              ),
              const Center(
                child: Text(
                  "Show this QR Code to the lost and found officer to claim the item.",
                  style: TextStyle(
                      fontSize: 13
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Caesar cipher encryption function
  String _caesarCipher(String text, int shift) {
    return String.fromCharCodes(
      text.runes.map((int rune) {
        var char = String.fromCharCode(rune);
        if (char.contains(RegExp(r'[a-z]'))) {
          return ((rune - 97 + shift) % 26 + 97);
        } else if (char.contains(RegExp(r'[A-Z]'))) {
          return ((rune - 65 + shift) % 26 + 65);
        } else if (char.contains(RegExp(r'[0-9]'))) {
          return ((rune - 48 + shift) % 10 + 48);
        } else {
          return rune;
        }
      }),
    );
  }
}
