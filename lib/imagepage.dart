import 'package:aichat/widgets/text_and_voice_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,

      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 245,
              padding: EdgeInsets.all(50),
              child: Center(child: Text("HI")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextAndVoiceField(),
          )
        ],
      ),
     

    );
  }
}