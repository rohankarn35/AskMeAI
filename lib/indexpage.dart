import 'package:aichat/constraints/constraints.dart';
import 'package:aichat/model/api_model.dart';
import 'package:aichat/model/chat_model.dart';
import 'package:aichat/provider/chat_provider.dart';
import 'package:aichat/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final chatprovider = Provider.of<chatProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "AskMe AI",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text("Developer: Rohan Karn")),
                  ])
        ],
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
                itemCount: chatprovider.getChatlist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      Clipboard.setData(new ClipboardData(
                              text: chatprovider.getChatlist[index].msg))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Copied!"),
                          // backgroundColor: Colors.red,
                        ));
                      });
                      // ScaffoldMessenger.of(context).showSnackBar(context: Text("Copied to clipboard")));
                    },
                    child: ChatWidget(
                      msg: chatprovider.getChatlist[index].msg,
                      chatIndex: chatprovider.getChatlist[index].chatIndex,
                    ),
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
                      await sendMessageCT(chatprovider: chatprovider);
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
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut);
  }

  Future<void> sendMessageCT({required chatProvider chatprovider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Try after the running process process completes"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Input.\nEmpty message not allowed"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      String txt = textEditingController.text;

      setState(() {
        _isTyping = true;
        //chatList.add(ChatModel(msg: txt, chatIndex: 0));
        chatprovider.addusermsg(msg: txt);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatprovider.sendmsg(msg: txt);

      // chatList.addAll(await ApiModel.messageModel(message: txt));
      setState(() {});
    } catch (error) {
      print("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollEnd();
        _isTyping = false;
      });
    }
  }
}
