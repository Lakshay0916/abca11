import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial_palmbook/logics/isAdmin.dart';

import 'package:trial_palmbook/students/register_form.dart';

class ConditionalWidgetPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!; // The document ID you want to check in Firestore



  @override
  Widget build(BuildContext context) {
    // Stream to get the document from Firestore based on the documentId
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
    FirebaseFirestore.instance.collection('Users').doc(user.uid).snapshots();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: documentStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error if any
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the data is loading, you can show a loading indicator or any other widget
          return CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          // If the document exists, open the first widget
          return HomePage();
        } else {
          // If the document doesn't exist, open the second widget
          return RegistrationPage();
        }
      },
    );
  }
}