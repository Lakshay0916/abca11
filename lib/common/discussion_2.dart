import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class discussion_forum extends StatefulWidget {
  const discussion_forum({Key? key}) : super(key: key);
  @override
  State<discussion_forum> createState() => _discussion_forumState();
}

class _discussion_forumState extends State<discussion_forum> {
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
          padding: EdgeInsets.only(left: width*.05,right: width*.05),
          child: SizedBox(
            width: width*.9,
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Column(
                children: [
                  SizedBox(
                    width: width*.9,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xFF7785FC),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yash Gupta",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "  .  ",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                    ),
                                  ),
                                  Text(
                                    "2hrs ago",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Expanded(
                            //   child: Container(
                            //     width: 2,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            Expanded(
                              child: SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 58),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi Hello Bye d dsdsd s d s sds d s ds  sd ds s sd d s  d f fs  s ds ds f sdf sdf sdf sdf sdf sdf sd f sd d sd sds dsd  sdd ssd sd ds sd ds",
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 58.0, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.favorite_border),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(Icons.comment),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: width*.9,
                      height: 1,
                      color: const Color(0xFFB1B1B1),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
