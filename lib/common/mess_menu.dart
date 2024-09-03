// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: Text("Mess Menu",
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
                bottom: Radius.circular(15)
            )
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: SizedBox(
            width: width * 0.9,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('mess')
                  .doc(DateFormat('yyyy-MM-dd').format(DateTime.now())) // Fetch today's document
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData && snapshot.data!.exists) {
                  final DocumentSnapshot menu = snapshot.data!;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: width*.07),
                        child: Container(
                          width: width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset("assets/icons/Heart.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Breakfast",
                                style: TextStyle(
                                    color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.01),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(menu["breakfast"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.05),
                        child: Container(
                          width: width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset("assets/icons/Heart.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Lunch",
                                style: TextStyle(
                                    color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.01),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(menu["lunch"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.05),
                        child: Container(
                          width: width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset("assets/icons/Heart.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Snacks",
                                style: TextStyle(
                                    color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.01),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(menu["snacks"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.05),
                        child: Container(
                          width: width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset("assets/icons/Heart.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Dinner",
                                style: TextStyle(
                                    color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width*.01),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF979797).withOpacity(0.1), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 1, // Blur radius
                                  offset: const Offset(2, 4),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(menu["dinner"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // No documents found in the query results
                  return const Center(
                    child: Text('Menu not updated'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
