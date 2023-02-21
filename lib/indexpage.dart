import 'package:aichat/constraints/constraints.dart';
import 'package:aichat/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // SimpleDialog(
                //   title: Text("Select Model"),
                //   children: <Widget>[
                //     SimpleDialogOption(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       child: Text(
                //         'Option 1',
                //         style: TextStyle(fontSize: 16, color: Colors.white),
                //       ),
                //     )
                //   ],
                // );
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
        title: Text(
          "AskMe AI",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 8.0,
        shadowColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.black45,
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatMessage[index]["msg"].toString(),
                      chatIndex:
                          int.parse(chatMessage[index]["chatIndex"].toString()),
                    );
                  })),
          if (_isTyping) ...[
            const SpinKitChasingDots(
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.white10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value) {},
                      decoration: InputDecoration.collapsed(
                          hintText: "Ask me anything",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ]
        ],
      )),
    );
  }
}
