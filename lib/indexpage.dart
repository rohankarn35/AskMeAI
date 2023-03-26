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

  // @override
  // void dispose() {
  //   _listScrollController.dispose();
  //   textEditingController.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final chatprovider = Provider.of<chatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
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
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 250, 249, 246),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    focusNode: focusNode,
                                    controller: textEditingController,
                                    onFieldSubmitted: (value) async {
                                      await sendMessageFCT(
                                          chatProvider: chatprovider);
                                      scrollListToEND();
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        hintText: ' Enter your prompt',
                                        hintStyle: TextStyle(
                                          color: Colors.black45,
                                        ),
                                        alignLabelWithHint: false,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: 180,
                        height: 44,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.white),
                            onPressed: () async {
                              print("Clicked");
                              await sendMessageFCT(chatProvider: chatprovider);
                              scrollListToEND();
                            },
                            child: Text(
                              'Get Answer',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )))
                  ],
                ),
              ),
            )
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
