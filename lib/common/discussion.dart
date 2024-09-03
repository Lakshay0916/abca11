import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial_palmbook/components/wall_post.dart';
import 'package:trial_palmbook/helper/helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class test3 extends StatefulWidget {
  const test3({super.key});

  @override
  State<test3> createState() => _test3State();
}
Future<String> name() async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;

      // Assuming getData returns a Future<String>
      String name = await getData(uid);
      return name;
      print('Name: $name');
    } else {
      print('User not logged in.');
      return '';
    }
  } catch (e) {
    print('Error: $e');
    return '';
  }
}
Future<String> prof() async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;

      // Assuming getData returns a Future<String>
      String pro = await getpro(uid);
      return pro;
      print('Name: $pro');
    } else {
      print('User not logged in.');
      return '';
    }
  } catch (e) {
    print('Error: $e');
    return '';
  }
}

Future<String> getData(String uid) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    DocumentReference documentRef = users.doc(uid);

    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      // Replace 'fieldName' with the actual field name you want to retrieve as a string
      String fieldValue = documentSnapshot.get('Name');
      return fieldValue;
    } else {
      print('Document does not exist');
      return ''; // or handle the absence of data in another way
    }
  } catch (e) {
    print('Error getting document: $e');
    return ''; // or handle the error in another way
  }
}

Future<String> getuid() async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      return uid;
    } else {
      // print('User not logged in.');
      return '';
    }
  } catch (e) {
    // print('Error: $e');
    return '';
  }
}

Future<String> getpro(String uid) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    DocumentReference documentRef = users.doc(uid);

    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      // Replace 'fieldName' with the actual field name you want to retrieve as a string
      String fieldValue = documentSnapshot.get('profile_image');
      return fieldValue;
    } else {
      print('Document does not exist');
      return ''; // or handle the absence of data in another way
    }
  } catch (e) {
    print('Error getting document: $e');
    return ''; // or handle the error in another way
  }
}


class _test3State extends State<test3> {
  final textController = TextEditingController();


  void postmessage(String message) async {
    String userName = await name();
    String profile = await prof();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (userName.isNotEmpty && message.isNotEmpty) {
      FirebaseFirestore.instance.collection("UserPosts").add({
        'User': userName,
        'Message': message,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
        'email': currentUser?.email,
        'profile': profile
      });
    }
  }

  String showMenu = "All"; // Default is "All"
  Widget buildFilterButton(String category) {
    bool isSelected = showMenu == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            showMenu = category;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 30,
          width: 50,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF7785FC) : Colors.white,
            border: Border.all(color: const Color(0xFF7785FC)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF7785FC),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
    elevation: 0,
        title: Text("Discussion Forum",
          style: GoogleFonts.poppins (
              textStyle: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
              )
          ),),
        toolbarHeight: 62,
    centerTitle: true,
    // leading: IconButton(
    //   icon: Image.asset("assets/icons/menu.png"), // set your color here
    //   onPressed: () {
    //     scafoldKey.currentState.openDrawer();
    //   },
    // ),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(15)
    )
    ),


    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
    fontSize: 20,
    color: Colors.white
    ),
    ),
      body:Center(
        child: Column(
          children: [Padding(
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, top: 15, bottom: 15),
            child: Row(
              children: [
                
                SizedBox(
                  width: 50, // Set the width of the button here
                  child: buildFilterButton("All"),
                ),
                SizedBox(
                  width: 80, // Set the width of the button here
                  child: buildFilterButton("General"),
                ),
                SizedBox(
                  width: 80, // Set the width of the button here
                  child: buildFilterButton("Events"),
                ),
                SizedBox(
                  width: 110, // Set the width of the button here
                  child: buildFilterButton("Complaints"),
                ),
              ],

            ),
          ),Expanded(child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("UserPosts")
                .orderBy("TimeStamp", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var posts = snapshot.data!.docs;
                if (showMenu != "All") {
                  posts = posts.where((post) => post['Category'] == showMenu).toList();
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return WallPost(
                      message: post['Message'],
                      user: post['User'],
                      postId: post.id,
                      likes: List<String>.from(post['Likes'] ?? []),
                      time: DateFormat('d MMMM yyyy, hh:mma').format(post['TimeStamp'].toDate()),
                      email: post['email'],

                      uid: post['uid'],
                      imageUrl: post['ImageUrl'],
                      category: post['Category'],
                    // Pass the category
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error' + snapshot.error.toString()),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),)
            ,

              ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPostScreen()),
            ).then((message) {
              if (message != null) {
                postmessage(message);
              }
            });
          });

    },
          child: Icon(
            Icons.add,
            color: Colors.white, // Change the color of the plus sign to white
          ),
          backgroundColor: const Color(0xFF7785FC),
    ),
    );
  }
}

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final textController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  bool isLoading = false;
  // Define the list of categories
  String selectedCategory = 'General';
  final List<String> categories = ['General', 'Events', 'Complaints'];
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images')
          .child(DateTime.now().toString() + '.jpg');

      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> postMessage(String message, String? imageUrl) async {
    String userName = await name();

     String uid = await getuid();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (userName.isNotEmpty && message.isNotEmpty) {
      FirebaseFirestore.instance.collection("UserPosts").add({
        'User': userName,
        'Message': message,
        'ImageUrl': imageUrl,
        'uid' : uid,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
        'email': currentUser?.email,
        // 'profile': profile,
        'Category': selectedCategory,  // Add category to the post
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post",
          style: GoogleFonts.poppins (
              textStyle: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
              )
          ),),
        toolbarHeight: 62,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Image.asset("assets/icons/menu.png"), // set your color here
        //   onPressed: () {
        //     scafoldKey.currentState.openDrawer();
        //   },
        // ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15)
            )
        ),


        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF7785FC),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Write something on the wall...',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16),
              _image != null ? Image.file(_image!) : Container(),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              SizedBox(height: 16)
              ,ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  String? imageUrl;
                  if (_image != null) {
                    imageUrl = await uploadImage(_image!);
                  }
                  await postMessage(textController.text, imageUrl);

                  setState(() {
                    isLoading = false;
                  });

                    Navigator.pop(context);




                },
                child: Text("Post"),
              ),
              SizedBox(height: 16),
              if (isLoading)
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
