import 'package:aichat/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../model/api_model.dart';

class chatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatlist {
    return chatList;
  }

  void addusermsg({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendmsg({required String msg}) async {
    chatList.addAll(await ApiModel.messageModel(message: msg));
    notifyListeners();
  }
}
