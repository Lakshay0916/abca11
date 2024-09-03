// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial_palmbook/common/test2.dart';
import 'package:trial_palmbook/guard/guard_dashboard.dart';
import 'package:trial_palmbook/students/navbar.dart';
import 'package:trial_palmbook/warden/dashboard_warden.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkUserTypeAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> checkUserTypeAndNavigate() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData =
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      final userType = userData.get('User Type');
      if (userType == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const test2()),
        );
      }
      else if (userType == 'warden') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const dashboard_warden()),
        );
      }
      else if (userType == 'guard') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const guard_dashboard()),
        );
      }
      else if (userType == 'super_admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const test2()),
        );
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
  }
}