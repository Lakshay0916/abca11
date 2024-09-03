// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gatepass_full_request.dart';

class gatepass_requests extends StatefulWidget {
  const gatepass_requests({super.key});

  @override
  State<gatepass_requests> createState() => _gatepass_requestsState();
}

class _gatepass_requestsState extends State<gatepass_requests> {
  String selectedStatus = 'All'; // Default to show all requests
  late Future<String?> hostelFuture;

  @override
  void initState() {
    super.initState();
    hostelFuture = getHostel();
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
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue ?? 'All';
                    });
                  },
                  items: <String>['All', 'Submitted', 'Approved', 'Rejected', 'Others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                        .where('hostel', isEqualTo: hostel).orderBy("start",descending:true)
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
                        request['status'] != 'Submitted' &&
                            request['status'] != 'Approved' &&
                            request['status'] != 'Rejected') ?? []);
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
                                    builder: (context) => gatepass_full_request(gatepassId: request['request_id']),
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
