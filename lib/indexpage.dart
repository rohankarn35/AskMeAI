import 'package:aichat/constraints/constraints.dart';
import 'package:aichat/model/api_model.dart';
import 'package:aichat/model/chat_model.dart';
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
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;
  @override
  void initState() {
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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
          child: Column(children: [
        Flexible(
            child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                  );
                })),
        if (_isTyping) ...[
          const SpinKitChasingDots(
            color: Colors.white,
            size: 18,
          ),
        ],
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
                  focusNode: focusNode,
                  style: const TextStyle(color: Colors.white),
                  controller: textEditingController,
                  onSubmitted: (value) {},
                  decoration: InputDecoration.collapsed(
                      hintText: "Ask me anything",
                      hintStyle: TextStyle(color: Colors.white)),
                )),
                IconButton(
                    onPressed: () async {
                      await sendMessageCT();
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        )
      ])),
    );
  }

  void scrollEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 3),
        curve: Curves.bounceIn);
  }

  Future<void> sendMessageCT() async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });

      chatList.addAll(
          await ApiModel.messageModel(message: textEditingController.text));
      setState(() {});
    } catch (error) {
      print("error $error");
    } finally {
      setState(() {
        scrollEnd();
        _isTyping = false;
      });
    }
  }
}
