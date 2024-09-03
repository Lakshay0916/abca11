import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class test2 extends StatelessWidget {
  const test2({super.key});

  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Vector.png"),
              SizedBox(
                height: 30,
              ),
              const Text("Feature Coming Soon.",
                style: TextStyle(
                    color: Color(0xFF7785FC),
                    fontSize: 20
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
