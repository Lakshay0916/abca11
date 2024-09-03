import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial_palmbook/logics/utils.dart';


class create_shuttle_slot extends StatefulWidget {
  const create_shuttle_slot({Key? key}) : super(key: key);

  @override
  State<create_shuttle_slot> createState() => _create_shuttle_slotState();
}

class _create_shuttle_slotState extends State<create_shuttle_slot> {
  final user = FirebaseAuth.instance.currentUser!;
  late DateTime selectedDateTime;
  final _formKey = GlobalKey<FormState>();
  late DateTime date;
  String src = '';
  String dest = '';
  String seats = '';
  String price = '';
  TextEditingController _dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7785FC),
        elevation: 0,
        title: const Text("Create Shuttle Slot"),
        centerTitle: true,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Source',
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
                          return 'Please enter source of shuttle.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        src = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Destination',
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
                          return 'Please enter destination of shuttle.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        dest = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Seats',enabledBorder: OutlineInputBorder(
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
                        return 'Please enter number of seats on shuttle.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      seats = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Price',
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
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price per seat.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      price = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _dateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date and Time of Departure',
                      // suffixIcon: Icon(Icons.calendar_today),
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
                      ),
                    ),
                    onTap: _selectDateTime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date and time.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _createslot();
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: width,
                      height: 55,

                      decoration: BoxDecoration(
                          color: const Color(0xff7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(child: Text('Create Slot',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
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
    String ID = await getid();
    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('Shuttle');


      DocumentReference<Map<String, dynamic>> newDocumentRef = collectionReference.doc(ID);


      await newDocumentRef.set({
        'Shuttle_ID' : ID,
        'dest' : dest,
        'src' : src,
        'seats' : seats,
        'price' : price,
        'status' : 'Active',
        'date' : selectedDateTime
      });
      Utils.showSnackBar(
        "Slot Created for ${src} to ${dest}",
      );

      // Document creation successful
      print('Document created with ID: ${newDocumentRef.id}');
    } catch (e) {
      // Handle errors
      print('Error creating document: $e');
    }



  }

  static getid() async {
    final collectionRef = FirebaseFirestore.instance.collection('Shuttle');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final ticketIds = [];
    for (final doc in documents) {
      ticketIds.add(doc.id.toString());
    }
    int i = ticketIds.length-1;
    int newTicketId = int.parse(ticketIds[i].toString())+1;
    print(newTicketId);
    return newTicketId.toString();
  }

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        print(selectedDateTime);

        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  // void saveToFirebase(DateTime dateTime) {
  //   // Save dateTime to Firebase
  //   FirebaseFirestore.instance.collection('your_collection').add({
  //     'selectedDateTime': dateTime,
  //     // Add other fields as needed
  //   });
  // }
}
