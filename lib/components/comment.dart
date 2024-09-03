import 'package:flutter/material.dart';
import 'package:trial_palmbook/components/delete_button.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment({super.key,
  required this.text,
    required this.user,
  required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF979797).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(2, 4),
              ),
            ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

              
              
              // User and Time Row
              Row(
                children: [
                  // User Name
                  Text(
                    user,
                    style: TextStyle(
                      fontSize: 14.0, //  font size of the username
                      color: Colors.grey[700], //  color of the username
                      fontWeight: FontWeight.w600, // font weight for the username
                    ),
                  ),
                  const SizedBox(width: 4.0), // Space between user and dash
                  
                  // Dash
                  Text(
                    '-',
                    style: TextStyle(
                      color: Colors.grey[700], 
                    ),
                  ),
                  const SizedBox(width: 4.0), // Space between dash and time
                  
                  // Time
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.0, //  font size for the time
                      color: Colors.grey[500], // color for the timestamp
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0), // Space between comment text and user info
              //comment text
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0, // font size of the comment text
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
