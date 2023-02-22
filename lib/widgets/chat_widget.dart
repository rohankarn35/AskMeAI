import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});
  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: chatIndex == 0
          ? EdgeInsets.fromLTRB(150.0, 20.0, 0, 0)
          : EdgeInsets.fromLTRB(0, 40.0, 150, 0),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.red),
      //     borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Material(
            color: chatIndex == 0 ? Colors.deepPurple : Colors.purple,
            // borderRadius: BorderRadius.all(Radius.circular(20))),
            borderRadius: chatIndex == 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(10))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(10)),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    chatIndex == 0
                        ? Image.asset(
                            "asset/1677054384254(1).png",
                            height: 30,
                            width: 30,
                            // colorBlendMode: BlendMode.overlay,
                          )
                        : Image.asset(
                            "asset/1677054412094.png",
                            height: 40,
                            width: 40,
                            // alignment: Alignment.center,
                          ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        msg,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
