// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:trial_palmbook/students/Claim_Item_QR.dart';

class LostNFound_Full extends StatefulWidget {
  final String ID;

  const LostNFound_Full({super.key, required this.ID});

  @override
  State<LostNFound_Full> createState() => _LostNFound_FullState();
}

class _LostNFound_FullState extends State<LostNFound_Full> {
  late Future<DocumentSnapshot> IDData;

  @override
  void initState() {
    super.initState();
    IDData = getLostnFoundData(widget.ID);
  }

  Future<DocumentSnapshot> getLostnFoundData(String LostnFoundId) async {
    return await FirebaseFirestore.instance.collection('lostnfound').doc(LostnFoundId).get();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future: IDData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var gatepass = snapshot.data?.data() as Map<String, dynamic>?;

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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Item:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass?['Item'] ?? 'N/A'}", // Replace 'name' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Receiving:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${DateFormat('d MMMM yyyy, h:mm a').format(gatepass!['Date'].toDate().toLocal())}", // Replace 'start' with the actual field name
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${gatepass['Description']??"-"}", // Replace 'start' with the actual field name
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
                            image: NetworkImage(gatepass['Image'])
                        )
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClaimItemQR(id: widget.ID),));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF7785FC),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      height: 50,
                      width: width*.9,
                      child: const Center(
                        child: Text(
                            "Claim this item.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
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