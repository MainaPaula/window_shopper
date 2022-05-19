import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';


class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {

  botResponse(query) async {
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/windowshopper-f8202-f55ebc628c5b.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    print(aiResponse);
    /*setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0]
      });
    });*/
  }

  final userQuery = TextEditingController();
  List<Map> messages = [];

  @override
  initState(){
    super.initState();
    messages = [];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WindowShopper Assistant', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
          child: ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => chat(messages[index]["message"],
              messages[index]["data"]),
          itemCount: messages.length,
            )),
            Divider(
              height: 5.0,
            ),

            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                        controller: userQuery,
                        decoration: InputDecoration.collapsed(
                         hintText: "Send your message"
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 30,
                      color: Colors.redAccent,
                      onPressed: () {
                        if(userQuery.text.isEmpty){
                          print("Message empty");
                        }else {
                          setState(() {
                            messages.insert(0,
                                {"data": 1,"message": userQuery.text});
                          });
                          botResponse(userQuery.text);
                          userQuery.clear();
                        }

                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Colors.red : Colors.redAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(
                      data == 0 ? "assets/bot.png" : "assets/user.png"),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          )),
    );
  }
}
