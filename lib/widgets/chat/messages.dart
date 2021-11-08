import 'package:chaoschat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (ctx, idx) => MessageBubble(
            message: docs[idx]['text'],
            isMe: docs[idx]['userId'] == FirebaseAuth.instance.currentUser!.uid,
            keyMsg: ValueKey(docs[idx].id),
            username: docs[idx]['username'],
            imageUrl: docs[idx]['userImage'],
          ),
          itemCount: docs.length,
          reverse: true,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
