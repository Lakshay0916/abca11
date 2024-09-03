// ignore_for_file: depend_on_referenced_packages, must_be_immutable, no_logic_in_create_state, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


class gatepass_details extends StatefulWidget {
  String request_id;
  gatepass_details({super.key, required this.request_id});

  @override
  State<gatepass_details> createState() => _gatepass_detailsState(request_id);
}

class _gatepass_detailsState extends State<gatepass_details> {
  late String request_id;
  _gatepass_detailsState(this.request_id);
  late List<Map<String, dynamic>> gatepassDetails;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: Text("Gatepass",
          style: GoogleFonts.poppins (
              textStyle: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
              )
          ),),
        toolbarHeight: 62,
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
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: SizedBox(
            width: width * .9,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Gatepass Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: _fetchGatepassDetails(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: Text("Loading"));
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Out",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Return",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                      fontSize: 18,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    " : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    " : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    " : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gatepassDetails[0]["name"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${DateFormat('d MMMM yyyy, h:mm a').format(gatepassDetails[0]['start'].toDate().toLocal())}"
,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${DateFormat('d MMMM yyyy, h:mm a').format(gatepassDetails[0]['end'].toDate().toLocal())}"
,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    gatepassDetails[0]["status"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              QrImageView(
                                data: gatepassDetails[0]["request_id"],
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _gatepassDetails() async {
    final List<Map<String, dynamic>> gatepassDetails = [];
    final collectionRef = FirebaseFirestore.instance.collection('Gatepass');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;

    for (final doc in documents) {
      if (doc.data()["request_id"].toString() == request_id) {
        gatepassDetails.add(doc.data());
      }
    }

    return gatepassDetails;
  }

  Future<List<Map<String, dynamic>>> _fetchGatepassDetails() async {
    gatepassDetails = await _gatepassDetails();
    return gatepassDetails;
  }
}
