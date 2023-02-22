import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aichat/model/chat_model.dart';
import 'package:http/http.dart' as http;

class ApiModel {
  static Future<List<ChatModel>> messageModel({required String message}) async {
    var response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {'Authorization': 'Bearer ', "Content-Type": "application/json"},
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": message,
          "max_tokens": 1000,
        },
      ),
    );
    Map jsonResponse = jsonDecode(response.body);
    if (jsonResponse['error'] != null) {
      throw HttpException(jsonResponse['error']["message"]);
    }
    List<ChatModel> chatlist = [];
    if (jsonResponse["choices"].length > 0) {
      // log("${jsonResponse["choices"][0]["text"]}");
      chatlist = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1));
    }
    return chatlist;
  }
}
