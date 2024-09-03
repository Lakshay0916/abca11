import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';



class studentDetails extends StatelessWidget {
  String user_uid;
  studentDetails({super.key,
    required this.user_uid
  });
  late List<Map<String, dynamic>> user_details;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
      body: FutureBuilder(
        future: _fetchgetUserName(),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: Text("Loading"));
          }
          if(snapshot.hasData) {
            return Center(
              child: SizedBox(
                height: height,
                width: width*.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    user_details[0]["profile_image"] == null?
                    Icon(Icons.supervised_user_circle,
                        size: width*.2,
                        color: Colors.white
                    ):
                    CircleAvatar(
                      radius: width*.2,
                      backgroundImage:
                      NetworkImage(user_details[0]["profile_image"]),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      user_details[0]["Name"],
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                      ),
                    ), //Name
                    Text(
                      user_details[0]["EnrollmentNumber"],
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ), //Enrollment No
                    Text(
                      "${user_details[0]["course"]}, ${user_details[0]["batch"]}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ), //Course and Batch
                    Text(
                      user_details[0]["Hostel"],
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                          onTap: (){
                            FlutterPhoneDirectCaller.callNumber(user_details[0]["Phone_Number"]);
                          },
                          child: Container(
                            width: width,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF7785FC),
                            ),
                            child: const Center(child: Text("Call",style: TextStyle(fontSize: 20,color: Colors.white)),),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchgetUserName() async {
    user_details = await getUserName();
    return user_details;
  }

  Future<List<Map<String, dynamic>>> getUserName() async{
    final List<Map<String, dynamic>> user_details = [];
    final collectionRef = FirebaseFirestore.instance.collection('Users');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;

    for (final doc in documents) {
      if(doc.data()["uid"].toString() == user_uid) {
        user_details.add(doc.data());
      }
    }
    return user_details;
  }
}
