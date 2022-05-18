import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Chats"),
          actions: [
            IconButton(
              onPressed: (){
                //searchUser();
              },
              icon: Icon(Icons.search),
            ),

          ],
        ),
        body: Container(
            child: Column(
              children: [
                //Text("${chatUserUid}"),
                const SizedBox(height: 45),

              ]
               // Text("${currentUser}")],
            ),
        )
    );
  }
}
