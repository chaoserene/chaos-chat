import 'package:chaoschat/widgets/chat/messages.dart';
import 'package:chaoschat/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chaos chat'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Log out'),
                        ],
                      ),
                    ))
              ],
              onChanged: (item) async {
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [Expanded(child: Messages()), NewMessage()],
          ),
        ));
  }
}
