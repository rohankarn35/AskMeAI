import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});
  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeN43RE_FzIpaNGQxY2Lj5muwFZd36QDqKj6p92H3wEZ-Ac7K0S2Z1t8mPa80YBrM-PWM&usqp=CAU",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      msg,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
