import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class shuttle_ticket extends StatefulWidget {
  const shuttle_ticket({Key? key}) : super(key: key);

  @override
  State<shuttle_ticket> createState() => _shuttle_ticketState();
}

class _shuttle_ticketState extends State<shuttle_ticket> {
  String dropdownValue = 'All';
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
          padding: EdgeInsets.only(left: width*0.05, right: width*.05),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              DropdownButton(
                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                value: dropdownValue,
                items: <String>['All', 'Future', 'Completed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFF7785FC),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
              const Padding(

                padding: EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text("You haven't reserved any seat yet."),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.only(top: width*.04),
              //   child: InkWell(
              //     onTap: (){
              //
              //     },
              //     child: Container(
              //       width: width*.9,
              //       height: 100,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Color(0xFF979797).withOpacity(0.1), // Shadow color
              //               spreadRadius: 1, // Spread radius
              //               blurRadius: 1, // Blur radius
              //               offset: const Offset(2, 4),
              //             )
              //           ]
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 20),
              //             child: Row(
              //               children: [
              //                 Image.asset("assets/icons/Location.png"),
              //                 const SizedBox(
              //                   width: 20,
              //                 ),
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: width*.65,
              //                       child: const Text(
              //                         "Campus to Iffco Chowk Metro Station",
              //                         style: TextStyle(
              //                             color: Color(0xFF7785FC)
              //                         ),
              //                       ),
              //                     ),
              //                     const Row(
              //                       children: [
              //                         Text(
              //                           "Date: ",
              //                           style: TextStyle(
              //                               color: Color(0xFF7785FC)
              //                           ),
              //                         ),
              //                         Text(
              //                           "04/12/2023",
              //                           style: TextStyle(
              //                               color: Color(0xFF7785FC)
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     const Row(
              //                       children: [
              //                         Text(
              //                           "Status: ",
              //                           style: TextStyle(
              //                               color: Color(0xFF7785FC)
              //                           ),
              //                         ),
              //                         Text(
              //                           "Confirm",
              //                           style: TextStyle(
              //                               color: Color(0xFF7785FC)
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(right: 20),
              //             child: Image.asset("assets/icons/Arrow - Right.png"),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
