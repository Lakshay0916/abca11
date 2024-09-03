// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial_palmbook/common/discussion.dart';
import 'package:trial_palmbook/common/upcoming.dart';
import 'package:trial_palmbook/students/lost_and_found.dart';
import 'package:trial_palmbook/students/shuttle.dart';
import 'package:trial_palmbook/students/shuttle_info.dart';
import '../common/mess_menu.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gatepass.dart';
import 'package:intl/intl.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  File? _selectedImage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var dt = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    double width = MediaQuery.of(context).size.width;
    // Color(0xFF7785FC)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: Text("PalmBook",
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
      drawer: Drawer(
        backgroundColor: const Color(0xFF7785FC),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(

                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('uid', isEqualTo: user?.uid)
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

                          if (snapshot.data!.docs.isNotEmpty) {
                            final DocumentSnapshot doc = snapshot.data!.docs[0];
                            final profileImage = doc['profile_image'] as String?;

                            return Column(
                              children: [
                                if (profileImage == null || profileImage.isEmpty)
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.supervised_user_circle,
                                        size: width * .1,
                                        color: Colors.white,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectImage();
                                        },
                                        child: Container(
                                          height: width * .07,
                                          width: width * .3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.black38),
                                          ),
                                          child: const Center(child: Text("Upload Image")),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  InkWell(
                                    onTap: () {
                                      _selectImage();
                                    },
                                    child: Container(
                                      width: width * .15,
                                      height: width * .15,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(profileImage),
                                          fit: BoxFit.cover,
                                        ),

                                        borderRadius: BorderRadius.circular(150),
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  doc['Name'] != null ? doc['Name'] as String : 'No Name',
                                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            );
                          } else {
                            // No documents found in the query results
                            return const Center(
                              child: Text('Error'),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => test3(),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.forum, // Use predefined icons from the Material Icons library
                                  color: Colors.white, // Specify the icon color if needed
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "Discussion Forum",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const upcoming(),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/people_alt_black_24dp 1.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Faculty Appointment",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const upcoming(),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/payments_black_24dp 1.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Cabin Availability",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const menu(),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Icon(
                              Icons.restaurant, // Use predefined icons from the Material Icons library
                              color: Colors.white, // Specify the icon color if needed
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Mess Menu",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const shuttle_home(),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Image.asset("assets/icons/Ticket.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Shuttle Booking",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => signOut(context),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.logout, // Use predefined icons from the Material Icons library
                                  color: Colors.white, // Specify the icon color if needed
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                "assets/images/DRIP_17.png",
                height: width*.65,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: width*.05,right: width*.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: width*.05),
                child: Container(
                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  width: width*.9,
                  height: 200,
                  decoration: BoxDecoration(
                      color: const Color(0xFF7785FC),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Gatepass",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Request",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const gatepass_request(),));
                            },
                            child: Container(
                              height: 40,
                              width: 135,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.5)
                              ),
                              child: const Center(
                                child: Text(
                                  "Create Request",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF7785FC),
                                    fontWeight: FontWeight.bold


                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Image.asset("assets/images/DRIP_18.png")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width*.07,left: width*0.03, right: width*0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Shuttle Service",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const shuttle_home(),));
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFF7785FC),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
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

                  // Take only the first 2 shuttles
                  final displayedShuttles = upcomingShuttles.take(2).toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if (displayedShuttles.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: Text("No shuttle slots available within 24 hours."),
                            ),
                          ),
                        for (var shuttle in displayedShuttles)
                          Padding(
                            padding: EdgeInsets.only(top: width * 0.07),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShuttleInfo(
                                      shuttleId: shuttle['Shuttle_ID'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: width,
                                height: 60,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("assets/icons/Location.png"),
                                    Text("${shuttle['src']} to ${shuttle['dest']}"),
                                    Image.asset("assets/icons/Arrow - Right.png")
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: width*.07,left: width*0.03, right: width*0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Mess Menu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const menu(),));
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFF7785FC),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width*.07),
                child: DefaultTabController(
                  length: 4,
                  initialIndex: (dt.hour >= 0 && dt.hour < 10) ? 0 :
                  (dt.hour >= 10 && dt.hour < 15) ? 1 :
                  (dt.hour >= 15 && dt.hour < 18) ? 2 : 3,
                  child: Container(
                    width: width*.9,
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
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                          child: TabBar(
                            splashFactory: NoSplash.splashFactory,
                            labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
                            tabs: [
                              Tab(
                                text: "Breakfast",
                              ),
                              Tab(
                                text: "Lunch",
                              ),
                              Tab(
                                text: "Snacks",
                              ),
                              Tab(
                                text: "Dinner",
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('mess')
                              .doc(formattedDate) // Fetch today's document
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

                              return SizedBox(
                                height: 100,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Text(menu["breakfast"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Text(menu["lunch"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Text(menu["snacks"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Text(menu["dinner"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // No documents found in the query results

                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text('Menu not updated'),
                                ),
                              );


                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: width*.05, bottom: width*0.05),
                child: Container(
                  padding: EdgeInsets.only(left: width*.06,right: width*.06),
                  width: width*.9,
                  height: 200,
                  decoration: BoxDecoration(
                      color: const Color(0xFF7785FC),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Discussion",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Forum",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPostScreen(),));
                            },
                            child: Container(
                              height: 40,
                              width: 135,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.5)
                              ),
                              child: const Center(
                                child: Text(
                                  "Create Post",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF7785FC),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Image.asset("assets/images/discussion.png")
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: width*.05, bottom: width*0.05),
              //   child: Container(
              //     width: width*.9,
              //     height: 200,
              //     decoration: BoxDecoration(
              //         color: const Color(0xFF7785FC),
              //         borderRadius: BorderRadius.circular(25)
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             const Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Lost",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 25,
              //                       fontWeight: FontWeight.bold
              //                   ),
              //                 ),
              //                 Text(
              //                   "&",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 25,
              //                       fontWeight: FontWeight.bold
              //                   ),
              //                 ),
              //                 Text(
              //                   "Found",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 25,
              //                       fontWeight: FontWeight.bold
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             InkWell(
              //               onTap: (){
              //                 Navigator.push(context, MaterialPageRoute(builder: (context) => const Lost_And_Found(),));
              //               },
              //               child: Container(
              //                 height: 40,
              //                 width: 135,
              //                 decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(12.5)
              //                 ),
              //                 child: const Center(
              //                   child: Text(
              //                     "Check List",
              //                     style: TextStyle(
              //                         fontSize: 13,
              //                         color: Color(0xFF7785FC),
              //                       fontWeight: FontWeight.bold
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //         Image.asset("assets/images/discussion.png")
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),

      ),
    );
  }
  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    if(await _selectedImage!.length()<2*1024*1024) {
      try {
        Reference storageReference =
        FirebaseStorage.instance.ref().child("profile_pictures/${firebaseUser.uid}");
        UploadTask uploadTask = storageReference.putFile(_selectedImage!);
        TaskSnapshot snapshot = await uploadTask;
        // Get the download URL of the uploaded image.
        String _imageURL = await snapshot.ref.getDownloadURL();
        try {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(firebaseUser.uid.toString())
              .update({"profile_image": _imageURL});

        } catch (e) {
          print("Error updating document: $e");
        }
        setState(() {

        });
      } catch (error) {
        print("Error uploading image: $error");
        return null;
      }
    }
    else{
      showDialog(
          context: context,
          builder: (context){
            return Container(
              color: const Color.fromARGB(100, 22, 44, 33),
              child: AlertDialog(
                title: const Text("Error"),
                content: const Text("Image size exceeding 2mb."),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
                ],
              ),
            );
          });
    }

  }

  Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
    print(await imageFile.length());
    return null;
  }
}
