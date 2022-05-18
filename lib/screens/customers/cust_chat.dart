import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';


class CustChatScreen extends StatefulWidget {
  final chatUsersenderId;
  final chatUserName;

  const CustChatScreen({Key? key, this.chatUsersenderId, this.chatUserName}) : super(key: key);

  @override
  State<CustChatScreen> createState() => _CustChatScreenState(chatUsersenderId, chatUserName);
}

class _CustChatScreenState extends State<CustChatScreen> {
  final CollectionReference<Map<String, dynamic>> chats = FirebaseFirestore.instance.collection('chats');
  final chatUsersenderId;
  final chatUserName;
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  var chatDocumentId;
  final _message = TextEditingController();

  _CustChatScreenState(this.chatUsersenderId, this.chatUserName);

  void initState() {
    setState(() {
      super.initState();
      chats.where('users', isEqualTo: {chatUsersenderId:null, currentUser:null})
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot){
        if(querySnapshot.docs.isNotEmpty){
          chatDocumentId = querySnapshot.docs.single.id;
        }else {
          chats.add({'users':{currentUser:null, chatUsersenderId:null}
          }).then((value) => {
            chatDocumentId = value,
          });
        }
      }).catchError((e) {});
    });
  }

  void sendMessage(String message) {
    if (message == '') return;
    chats.doc(chatDocumentId).collection("messages").add(
        {
          'createdOn': FieldValue.serverTimestamp(),
          'senderId': currentUser,
          'message': message
        }
    ).then((value) {
      _message.text = '';
    });
  }

  bool isSender(String person) {
    return person == currentUser;
  }

  Alignment getAlignment(person) {
    if (person == currentUser) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDocumentId).collection('messages')
          .where('senderId', isNotEqualTo: currentUser)
          .orderBy('senderId')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading"),
          );
        }

        if(snapshot.hasData) {
          var data;
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: "Back",
              middle: Text(chatUserName),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(CupertinoIcons.phone),
              ),
            ),
            child: SafeArea(
              child:  Column(
                children: [
                  Expanded(
                      child: ListView(
                        reverse: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          data = document.data()!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper6(
                                  nipSize: 0,
                                  radius: 0,
                                  type: isSender(data['senderId'].toString())
                                      ? BubbleType.sendBubble : BubbleType.receiverBubble
                              ),
                              alignment: getAlignment(data['senderId'].toString()),
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor: isSender(data['senderId'].toString()) ? Color(0xff08c187) : Color(0xffe7E7D),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(data['msg'],
                                          style: TextStyle(
                                              color: isSender(
                                                  data['senderId'].toString()) ? Colors.white : Colors.black
                                          ),
                                          maxLines: 100,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text (
                                          data['createdOn'] == null ? DateTime.now().toString()
                                              : data['createdOn']
                                              .toDate()
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(
                                                  data['senderId'].toString()
                                              ) ? Colors.white : Colors.black
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ),
                          );
                        }).toList(),

                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: CupertinoTextField(
                            controller: _message,
                          )),
                      CupertinoButton(
                          child: Icon(Icons.send),
                          onPressed: () => sendMessage(_message.text))
                    ],
                  )
                ],
              ),
            ),);
        }
        return const Text("Error loading page");
      },
    );
  }
}
