// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial_palmbook/guard/guard_gatepass_full.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vibration/vibration.dart';


class guard_gatepass_requests extends StatefulWidget {
  const guard_gatepass_requests({Key? key}) : super(key: key);

  @override
  State<guard_gatepass_requests> createState() => _guard_gatepass_requestsState();
}

class _guard_gatepass_requestsState extends State<guard_gatepass_requests> {
  String selectedStatus = 'All'; // Default to show all requests
  late Future<String?> hostelFuture;
  String qrCodeResult = "Scan a QR code";

  @override
  void initState() {
    super.initState();
    hostelFuture = getHostel();
  }

  Future<void> startQRScan() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#7785FC', // Color of the scanning screen
        'Cancel', // Cancel button text
        true, // Enable flash
        ScanMode.QR, // Scan mode (QR code in this case)
      );

      if (!mounted) return; // Avoid setting state if the widget is disposed

      if (qrCode.toString() == "-1") {
        setState(() {
          qrCodeResult = qrCode; // Update the QR code result in the state
        });
      } else {
        Vibration.vibrate();

        // Search for the document in the "Gatepass" collection
        final gatepassDoc = await FirebaseFirestore.instance
            .collection('Gatepass')
            .doc(qrCode.toString())
            .get();

        if (gatepassDoc.exists) {
          final status = gatepassDoc['status'];

          if (status == 'Approved' || status == 'Out of Campus') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => guard_gatepass_full_request(gatepassId: qrCode.toString()),
              ),
            );
          } else {
            // Status is not approved or out of campus, deny access or show an error message
            // You can customize this part based on your application flow
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Access Denied'),
                  content: const Text('The gatepass is not transferred to Main Gate.'),
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
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Access Denied'),
                content: const Text('Invalid QR Code.'),
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
      }
    } catch (e) {
      setState(() {
        qrCodeResult = 'Failed to get QR code: $e'; // Display an error message if scanning fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: const Text("Gatepass"),
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
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: selectedStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue ?? 'All';
                          });
                        },
                        items: <String>['All', 'Approved', 'Out of Campus', 'Others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    InkWell(
                        onTap: startQRScan,
                        child: const Icon(Icons.qr_code_scanner_rounded,size: 29)
                    )
                  ],
                ),
              ),
              FutureBuilder<String?>(
                future: hostelFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
          
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
          
                  final String? hostel = snapshot.data;
          
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Gatepass')
                        .where('status', whereIn: ['Approved', 'Out of Campus']).orderBy("start",descending:true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
          
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
          
                      final requests = snapshot.data?.docs.cast<DocumentSnapshot>();
          
                      List<DocumentSnapshot> filteredRequests = [];
          
                      if (selectedStatus == 'All') {
                        filteredRequests.addAll(requests ?? []);
                      } else if (selectedStatus == 'Others') {
                        filteredRequests.addAll(requests?.where((request) =>
                        request['status'] != 'Approved' &&
                            request['status'] != 'Out of Campus') ?? []);
                      } else {
                        filteredRequests.addAll(requests?.where((request) =>
                        request['status'] == selectedStatus) ?? []);
                      }
          
                      return Column(
                        children: filteredRequests.map((request) {
                          final start = (request['start'] as Timestamp).toDate();
                          final status = request['status'] as String;
                          final name = request['name'] as String;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => guard_gatepass_full_request(gatepassId: request['request_id']),
                                  ),
                                );
                              },
                              child: Container(
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF979797).withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(2, 4),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 12,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Out Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                " : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                " : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                " : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${start.day}/${start.month}/${start.year}",
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                status,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Image.asset("assets/icons/Arrow - Right.png")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList() ?? [],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getHostel() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          return userDoc["Hostel"] as String?;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
