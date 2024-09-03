import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trial_palmbook/logics/utils.dart';
import 'package:uuid/uuid.dart';

class Lost_And_Found extends StatefulWidget {
  const Lost_And_Found({Key? key}) : super(key: key);

  @override
  State<Lost_And_Found> createState() => _Lost_And_FoundState();
}

class _Lost_And_FoundState extends State<Lost_And_Found> {
  final user = FirebaseAuth.instance.currentUser!;
  late DateTime DatenTime;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  late DateTime returnDateTime;
  String reason = '';
  String parentphone = '';
  TextEditingController _dateTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: const Text("Lost And Found"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // TextFormField(
                  //   controller: _dateTimeController,
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Out Date and Time*',
                  //     // suffixIcon: Icon(Icons.calendar_today),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Color(0xFF9B9B9B),
                  //           width: 0.5
                  //       ),
                  //     ),
                  //     errorBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Colors.red,
                  //           width: .5
                  //       ),
                  //     ),
                  //     focusedErrorBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Colors.red,
                  //           width: .5
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //         color: Colors.black,
                  //         width: .5,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: _outDateTime,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please select date and time.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // TextFormField(
                  //   controller: _dateTimeController2,
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Return Date and Time*',
                  //     // suffixIcon: Icon(Icons.calendar_today),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Color(0xFF9B9B9B),
                  //           width: 0.5
                  //       ),
                  //     ),
                  //     errorBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Colors.red,
                  //           width: .5
                  //       ),
                  //     ),
                  //     focusedErrorBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //           color: Colors.red,
                  //           width: .5
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius:
                  //       BorderRadius.circular(8),
                  //       borderSide: const BorderSide(
                  //         color: Colors.black,
                  //         width: .5,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: _returnDateTime,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please select date and time.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Item*',
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xFF9B9B9B),
                            width: 0.5
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: .5
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: .5
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: .5,
                        ),
                      ),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter item.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      reason = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Description*",enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xFF9B9B9B),
                          width: 0.5
                      ),
                    ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: .5
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: .5
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: .5,
                        ),
                      ),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter description.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      parentphone = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectImage();
                    },

                    child: const Text('Select Image*'),
                  ),
                  const SizedBox(height: 5.0),
                  if (_selectedImage != null)
                    Image.file(
                      _selectedImage!,
                      height: 500.0,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _createslot();
                      }
                    },
                    child: Container(
                      width: width,
                      height: 55,

                      decoration: BoxDecoration(
                          color: const Color(0xff7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createslot() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    String ID = Uuid().v4(); // Use Uuid to generate a random ID
    String? _imageURL = await uploadImageToFirebase(_selectedImage!, ID);
    _DateTime();

    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('lostnfound');
      DocumentReference<Map<String, dynamic>> newDocumentRef =
      collectionReference.doc(ID);

      await newDocumentRef.set({
        "I'd": ID,
        'Date': DatenTime,
        'Item': reason,
        'Description': parentphone,
        'Status': 'Pending',
        'Image': _imageURL,
      });

      Utils.showSnackBar(
        "Request Submitted",
      );
      Navigator.pop(context);
      Navigator.pop(context);

      // Document creation successful
      print('Document created with ID: ${newDocumentRef.id}');
    } catch (e) {
      // Handle errors
      print('Error creating document: $e');
    }
  }


  Future<void> _DateTime() async {
    DateTime? pickedDate = DateTime.now();

    TimeOfDay? pickedTime = TimeOfDay.now();

    DatenTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _dateTimeController.text = DatenTime.toString();
    });
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if(await pickedFile.length()<4194304) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
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
  }

  Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
    try {
      Reference storageReference =
      FirebaseStorage.instance.ref().child("LostAndFound/$fileName.jpg");

      // Set content type to image/jpeg
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

      UploadTask uploadTask = storageReference.putFile(
        imageFile,
        metadata,
      );

      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image.
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print("Error uploading image: $error");
      return null;
    }
  }
}
