// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:trial_palmbook/warden/studentDetails.dart';

class guard_gatepass_full_request extends StatefulWidget {
  final String gatepassId;

  const guard_gatepass_full_request({super.key, required this.gatepassId});

  @override
  State<guard_gatepass_full_request> createState() => _guard_gatepass_full_requestState();
}

class _guard_gatepass_full_requestState extends State<guard_gatepass_full_request> {
  late Future<DocumentSnapshot> gatepassData;

  @override
  void initState() {
    super.initState();
    gatepassData = getGatepassData(widget.gatepassId);
  }

  Future<DocumentSnapshot> getGatepassData(String gatepassId) async {
    return await FirebaseFirestore.instance.collection('Gatepass').doc(gatepassId).get();
  }

  void updateStatus(String status, String time, String campus, String user) async {
    await FirebaseFirestore.instance.collection('Gatepass').doc(widget.gatepassId).update({'status': status, time: DateTime.now()});
    await FirebaseFirestore.instance.collection('Users').doc(user).update({'Campus' : campus});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future: gatepassData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var gatepass = snapshot.data?.data() as Map<String, dynamic>?;

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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass?['name'] ?? 'N/A'}", // Replace 'name' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Out date and time:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass!['start'].toDate().toLocal().day}/${gatepass['start'].toDate().toLocal().month}/${gatepass['start'].toDate().toLocal().year}, ${DateFormat('h:mm a').format(gatepass['start'].toDate().toLocal())}", // Replace 'start' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Return date and time:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass['end'].toDate().toLocal().day}/${gatepass['end'].toDate().toLocal().month}/${gatepass['end'].toDate().toLocal().year}, ${DateFormat('h:mm a').format(gatepass['end'].toDate().toLocal())}", // Replace 'start' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Reason:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass['reason']}", // Replace 'reason' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    height: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(gatepass['screenshot'])
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => studentDetails(user_uid: gatepass['uid']),));
                    },
                    child: Container(
                      height: 55,
                      width: width,
                      decoration: BoxDecoration(
                          color: const Color(0xFF7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                        child: Text(
                            "View Student Profile",
                            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      FlutterPhoneDirectCaller.callNumber("${gatepass['parent_phone']}");
                    },
                    child: Container(
                      height: 55,
                      width: width,
                      decoration: BoxDecoration(
                          color: const Color(0xFF7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                        child: Text(
                            "Call Student's Parents",
                            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      if (gatepass['status'] == "Approved") // Check if status is not Approved
                        InkWell(
                          onTap: () {
                            updateStatus('Out of Campus','exit time','Out',"${gatepass['uid']}"); // Approve the gatepass
                          },
                          child: Container(
                            height: 55,
                            width: width * .9,
                            decoration: BoxDecoration(
                              color: gatepass['status'] == "Out of Campus" ? Colors.grey : const Color(0xFF7785FC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Check-Out",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      if (gatepass['status'] == "Out of Campus") // Check if status is not Out of Campus
                        InkWell(
                          onTap: () {
                            updateStatus('Returned to Campus','return time','In',"${gatepass['uid']}"); // Reject the gatepass
                          },
                          child: Container(
                            height: 55,
                            width: width * .9,
                            decoration: BoxDecoration(
                              color: gatepass['status'] == "Approved" ? Colors.grey : const Color(0xFF7785FC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Check-In",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
