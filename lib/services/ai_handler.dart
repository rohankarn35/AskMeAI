import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;

class AIHandler {
  final List<Map<String, String>> messages = [];
  Future<String> getResponse(String message) async {
    messages.add({
      'role': 'user',
      'content': message,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}


