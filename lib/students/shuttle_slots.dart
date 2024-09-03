import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:trial_palmbook/students/shuttle_info.dart';
import 'package:google_fonts/google_fonts.dart';

class shuttle_slots extends StatefulWidget {
  const shuttle_slots({Key? key}) : super(key: key);

  @override
  State<shuttle_slots> createState() => _shuttle_slotsState();
}

class _shuttle_slotsState extends State<shuttle_slots> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: Text("Shuttle",
          style: GoogleFonts.poppins (
              textStyle: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
              )
          ),),
        toolbarHeight: 62,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Shuttle').snapshots(),
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

          final shuttles = snapshot.data!.docs;

          final currentTime = DateTime.now();

          // Filter shuttles departing within the next 24 hours
          final upcomingShuttles = shuttles.where((shuttle) {
            final shuttleTime = (shuttle['date'] as Timestamp).toDate();
            final timeDifference = shuttleTime.difference(currentTime);

            return timeDifference.inHours >= 0 && timeDifference.inHours < 24;
          }).toList();

          if (upcomingShuttles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "No shuttle slots available within 24 hours.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }


          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.07, left: width * 0.03, right: width * 0.03),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Slots Available",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  // if (upcomingShuttles.isEmpty)
                  //   const Center(
                  //     child: Text("No shuttle slots available within 24 hours."),
                  //   ),
                  for (var shuttle in upcomingShuttles)
                    Padding(
                      padding: EdgeInsets.only(top: width * 0.04),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShuttleInfo(shuttleId: shuttle['Shuttle_ID']),));
                        },
                        child: Container(
                          width: width * 0.9,
                          height: 100,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Image.asset("assets/icons/Location.png"),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.5,
                                          child: Text(
                                            "${shuttle['src']} to ${shuttle['dest']}",
                                            style: const TextStyle(color: Color(0xFF7785FC)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Date: ",
                                              style: TextStyle(color: Color(0xFF7785FC)),
                                            ),
                                            Text(
                                              "${shuttle['date'].toDate().toLocal().day} / ${shuttle['date'].toDate().toLocal().month} / ${shuttle['date'].toDate().toLocal().year}",
                                              style: const TextStyle(color: Color(0xFF7785FC)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                          const Text(
                                            "Time: ",
                                            style: TextStyle(color: Color(0xFF7785FC)),
                                          ),
                                          Text(
                                            "${DateFormat('h:mm a').format(shuttle['date'].toDate().toLocal())}",
                                            style: const TextStyle(color: Color(0xFF7785FC)),
                                          ),
                                        ],
                                      ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Image.asset("assets/icons/Arrow - Right.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
