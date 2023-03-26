import 'dart:convert';
import 'dart:io';

import 'package:aichat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiModel {
  static Future<List<ChatModel>> messageModel({required String message}) async {
    var response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {'Authorization': '', "Content-Type": "application/json"},
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": message,
          "max_tokens": 3000,
          "temperature": 1,
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

class ImgApi {
  static final header = {
    "Content-Type": "application/json",
    'Authorization': '',
  };
  static final imgurl =
      Uri.parse('https://api.openai.com/v1/images/generations');
  static generateImage(String text, String size) async {
    var res = await http.post(
      imgurl,
      headers: header,
      body: jsonEncode(
        {
          "prompt": text,
          "n": 1,
          "size": size,
        },
      ),
    );
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      print(data['data'][0]['url']);
      // print(data.data[0]['imgurl'].toString());
      return data["data"][0]['url'].toString();
    } else {
      print("Error");
    }
  }
}
