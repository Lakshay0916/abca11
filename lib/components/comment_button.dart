import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentButton extends StatelessWidget {
  final String postId;
  final void Function()? onTap;
  const CommentButton({super.key, required this.onTap, required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("UserPosts")
          .doc(postId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                '...',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        }

        final postData = snapshot.data!.data() as Map<String, dynamic>;
        final int commentCount = postData['commentCount'] ?? 0;

        return Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.comment,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8.0), // Space between the button and count
            Text(
              '$commentCount',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        );
      },
    );
  }
}
