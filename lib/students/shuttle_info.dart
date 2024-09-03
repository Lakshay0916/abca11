// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';


class ShuttleInfo extends StatefulWidget {
  final String shuttleId;

  const ShuttleInfo({super.key, required this.shuttleId});

  @override
  _ShuttleInfoState createState() => _ShuttleInfoState();
}

class _ShuttleInfoState extends State<ShuttleInfo> {
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Shuttle').doc(widget.shuttleId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Shuttle not found'),
            );
          }

          final shuttleData = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Shuttle Information:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInfo(title: "Origin:", value: shuttleData['src']),
                const SizedBox(
                  height: 10,
                ),
                TextInfo(title: "Destination:", value: shuttleData['dest']),
                const SizedBox(
                  height: 10,
                ),
                TextInfo(title: "Date:", value: "${shuttleData['date'].toDate().toLocal().day} / ${shuttleData['date'].toDate().toLocal().month} / ${shuttleData['date'].toDate().toLocal().year}"),
                const SizedBox(
                  height: 10,
                ),
                TextInfo(title: "Time:", value: DateFormat('h:mm a').format(shuttleData['date'].toDate().toLocal())),
                const SizedBox(
                  height: 10,
                ),
                TextInfo(title: "Seats:", value: shuttleData['seats'].toString()),
                const SizedBox(
                  height: 10,
                ),
                TextInfo(title: "Price:", value: shuttleData['price'].toString()),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "By continuing, I agree to Terms and Conditions.",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    _bookTicket();
                  },
                  child: Container(
                    width: width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xff7785FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Reserve Seat',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Future<void> _bookTicket() async {
    String id = widget.shuttleId;
    String validity = await checkTicketStatus(id);

    if (validity == "false") {
      Navigator.of(context).pop(); // Dismiss the progress indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You have already reserved your space."),
        ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      String result = '';

      // var response = AllInOneSdk.startTransaction(
      //     mid, orderId, amount, txnToken, callbackurl, isStaging, restrictAppInvoke);
      // response.then((value) {
      //   print(value);
      //   setState(() {
      //     result = value.toString();
      //   });
      // }).catchError((onError) {
      //   if (onError is PlatformException) {
      //     setState(() {
      //       result = onError.message! + " \n  " + onError.details.toString();
      //     });
      //   } else {
      //     setState(() {
      //       result = onError.toString();
      //     });
      //   }
      // });


      await FirebaseFirestore.instance.runTransaction((transaction) async {
        String booked = await updateSeat(id, transaction);

        if (booked == "Confirm") {
          String ticketId = await getTicketId();
          final firebaseUser = FirebaseAuth.instance.currentUser!;

          final data = <String, dynamic>{
            "ticketID": ticketId,
            "shuttleID": id,
            "uid": firebaseUser.uid,
            "status": "Confirm",
          };

          await FirebaseFirestore.instance
              .collection("shuttleTickets")
              .doc(ticketId)
              .set(data)
              .onError((e, _) => print("Error writing document: $e"));

          Navigator.of(context).pop(); // Dismiss the progress indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your seat is confirmed. We wish you a safe and a happy journey."),
            ),
          );

          // Navigator.of(context).pop(); // Dismiss the progress indicator
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => bookNow(ticketId: ticketId)),
          // );
        } else {
          String ticketId = await getTicketId();
          final firebaseUser = FirebaseAuth.instance.currentUser!;

          final data = <String, dynamic>{
            "ticketID": ticketId,
            "shuttleID": id,
            "uid": firebaseUser.uid,
            "status": "Waiting",
          };

          await FirebaseFirestore.instance
              .collection("shuttleTickets")
              .doc(ticketId)
              .set(data)
              .onError((e, _) => print("Error writing document: $e"));
          Navigator.of(context).pop(); // Dismiss the progress indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No seats available. You are added to the waiting list."),
            ),
          );
        }
      });
    }
  }

  Future<String> updateSeat(String id, Transaction transaction) async {
    DocumentSnapshot shuttleDoc = await FirebaseFirestore.instance
        .collection("Shuttle")
        .doc(id)
        .get();

    int seats = shuttleDoc["seats"];

    if (seats > 0) {
      seats -= 1;

      try {
        transaction.update(
          FirebaseFirestore.instance.collection("Shuttle").doc(id),
          {"seats": seats},
        );
        return "Confirm"; // Seat booked successfully
      } catch (e) {
        print("Error updating document: $e");
        return "Error"; // Error occurred while booking seat
      }
    } else {
      // No seats available, add to waiting list
      return "Waiting";
    }
  }


  Future<String> getTicketId() async {
    final collectionRef = FirebaseFirestore.instance.collection('shuttleTickets');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final ticketIds = [];
    for (final doc in documents) {
      ticketIds.add(int.parse(doc.id));
    }
    int newTicketId = ticketIds.isEmpty ? 1 : ticketIds.reduce((value, element) => value > element ? value : element) + 1;
    return newTicketId.toString();
  }

  Future<String> checkTicketStatus(String id) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    final collectionRef = FirebaseFirestore.instance.collection('shuttleTickets');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;

    for (final doc in documents) {
      if (doc.data()["uid"].toString() == firebaseUser.uid && doc.data()["shuttleID"].toString() == id) {
        return "false"; // User already booked a seat
      }
    }
    return "true"; // User can book a seat
  }

}

class TextInfo extends StatelessWidget {
  final String title;
  final String value;

  const TextInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
