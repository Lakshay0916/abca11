import 'package:flutter/material.dart';
import 'package:trial_palmbook/students/shuttle_slots.dart';
import 'package:trial_palmbook/students/shuttle_ticket.dart';
import 'package:google_fonts/google_fonts.dart';

class shuttle_home extends StatelessWidget {
  const shuttle_home({Key? key}) : super(key: key);

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
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: width*.05, right: width*.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: width*.07),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => shuttle_slots(),));
                  },
                  child: Container(
                    width: width*.9,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF979797).withOpacity(0.1), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 1, // Blur radius
                            offset: const Offset(2, 4),
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Image.asset("assets/icons/Ticket2.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                  "Book Ticket",
                                style: TextStyle(
                                  color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset("assets/icons/Arrow - Right.png"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width*.07),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => shuttle_ticket(),));
                  },
                  child: Container(
                    width: width*.9,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF979797).withOpacity(0.1), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 1, // Blur radius
                            offset: const Offset(2, 4),
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Image.asset("assets/icons/Ticket2.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Manage Tickets",
                                style: TextStyle(
                                    color: Color(0xFF7785FC)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset("assets/icons/Arrow - Right.png"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
