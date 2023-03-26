import 'dart:developer';

import 'package:aichat/provider/chat_provider.dart';
import 'package:aichat/provider/chat_provider.dart';
import 'package:aichat/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'provider/chat_provider.dart';

class indexpage extends StatefulWidget {
  const indexpage({super.key});

  @override
  State<indexpage> createState() => _indexpageState();
}

class _indexpageState extends State<indexpage> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatprovider = Provider.of<chatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 10,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        title: const Text("AskMe AI"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text("Developer: Rohan Karn")),
                  ])
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        shadowColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                            content: Text("Copied to Clipboard!"),
                          ));
                        });
                      },
                      child: ChatWidget(
                        msg: chatprovider.getChatlist[index].msg,
                        chatIndex: chatprovider.getChatlist[index].chatIndex,
                      ),
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitChasingDots(
                color: Colors.white,
                size: 20,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: Colors.white12,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(chatProvider: chatprovider);
                          scrollListToEND();
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "Ask me anything",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(chatProvider: chatprovider);
                          scrollListToEND();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT({required chatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Prompt in progress"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Input.\n Message can't be empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addusermsg(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendmsg(
        msg: msg,
      );

      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
