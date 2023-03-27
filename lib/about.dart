import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  _launchURLBrowser() async {
    const url = 'https://github.com/flutter/flutter/issues/82496';
    var uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("About Page"),
          centerTitle: true,
          elevation: 10.0,
          shadowColor: Colors.blue,
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "ASKME AI",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "About App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "AskMe AI Android App is an AI-based mobile application that provides users with an easy way to ask questions and get answers.It can also generate AI based images according to user's prompt .Developed by Rohan Karn, this app uses AI technology to provide users with accurate answers to their questions.It also provides user with variety of features such as image generation, code completion and more. With AskMe AI Android App, users can quickly and easily get answers to their questions.\n\nThis is an open source project so you can check the code on GitHub and provide your  contribution.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 90,
                      ),
                      child: Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () async {
                                var url =
                                    "https://github.com/rohankarn35/AskMeAI";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'asset/github.png',
                                      width: 40,
                                      height: 50,
                                    ),
                                  ),
                                  Text(
                                    "Contribute",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ))))
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text(
                    "How to use",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "--> In the chat section, you can provide your prompt and get the answer.\n\n--> In the image section, you can provide your prompt,select the size and get the AI generated image.\n\n--> The reponse will take time depending upon your internet speed.\n\n\---> You will get random message if prompt given is not readable by AI.",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "Visit my portfolio to know more --> "),
              TextSpan(
                  text: "Click here",
                  style: TextStyle(color: Colors.purpleAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      var url = "https://www.rohankarn.com.np/";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
            ]))
          ],
        ));
  }
}
