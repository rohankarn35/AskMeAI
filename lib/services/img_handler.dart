import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

class ImgApi {
  static final header = {
    "Content-Type": "application/json",
    'Authorization':
      '',
  };
  static final imgurl =
      Uri.parse('https://api.openai.com/v1/images/generations');
  static generateImage(String text) async {
    // print(text);
    var res = await http.post(
      imgurl,
      headers: header,
      body: jsonEncode(
        {
          "prompt": text,
          "n": 1,
          "size": "1024x1024",
        },
      ),
    );
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      // print(data['data'][0]['url']);
      // print(data.data[0]['url'].toString());
      return data["data"][0]['url'].toString();
    } else {
      Text("Error");
    }
  }
}