import 'package:flutter/material.dart';
import 'package:trial_palmbook/guard/lost_and_found.dart';
import 'package:trial_palmbook/guard/scanLostAndFound.dart';

class lostAndFoundMain extends StatelessWidget {
  const lostAndFoundMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF7785FC),
          elevation: 0,
          title: const Text("Lost & Found"),
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
      body: Padding(
        padding: EdgeInsets.all(width*.07),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Lost_And_Found(),));
              },
              child: Container(
                height: 200,
                width: width*.4,
                decoration: BoxDecoration(
                    color: const Color(0xFF7785FC),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Center(
                  child: Text(
                    "Upload Item",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScanLostAndFound(),));
              },
              child: Container(
                height: 200,
                width: width*.4,
                decoration: BoxDecoration(
                    color: const Color(0xFF7785FC),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Center(
                  child: Text(
                    "Scan Item",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
