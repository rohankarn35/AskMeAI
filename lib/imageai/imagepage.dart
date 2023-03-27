// import 'dart:io';
import 'dart:io';
import 'dart:typed_data';

import 'package:aichat/model/api_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  var options = ["Small", "Medium", "Large"];
  var sized = ["256x256", "512x512", "1024x1024"];
  String? dropvalue;
  var imgtextcontroller = TextEditingController();
  String imaged = '';
  String waiting = 'Waiting for your prompt...';
  bool isloading = false;
  ScreenshotController screenshotController = ScreenshotController();

  downloadimag() async {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      final foldername = "AI Image";
      final path = Directory("/storage/emulated/0/Download");
      print(path);
      // final path = get
      final filename = "${DateTime.now().millisecondsSinceEpoch}.png";
      print(filename);
      if (await path.exists()) {
        await screenshotController.captureAndSave(path.path,
            delay: Duration(milliseconds: 100),
            fileName: filename,
            pixelRatio: 1.0);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Downloaded to ${path.path}"),
          backgroundColor: Color.fromARGB(255, 36, 218, 36),
        ));
      } else {
        await path.create();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission Denied!!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  shareImage() async {
    await screenshotController
        .capture(delay: Duration(milliseconds: 100), pixelRatio: 1.0)
        .then((Uint8List? img) async {
      if (img != null) {
        final directory = (await getApplicationDocumentsDirectory()).path;
        const filename = "AiImageshare.png";
        final imgpath = await File("$directory/$filename").create();

        await imgpath.writeAsBytes(img);
        print(img);
        Share.shareFiles([imgpath.path], text: 'Image Created By AskMeAI');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error!!'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                child: isloading
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 110),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Screenshot(
                                controller: screenshotController,
                                child: Image.network(
                                  imaged,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.download_rounded,
                                    color: Colors.black,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(8),
                                      backgroundColor:
                                          Color.fromARGB(255, 248, 246, 246)),
                                  onPressed: () async {
                                    downloadimag();
                                  },
                                  label: Text(
                                    'Download',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color: Colors.black,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(8),
                                      backgroundColor:
                                          Color.fromARGB(255, 248, 246, 246)),
                                  onPressed: () async {
                                    await shareImage();
                                  },
                                  label: Text(
                                    'Share',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30,
                                duration: Duration(milliseconds: 800),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                            ),
                            Text(
                              waiting,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
              )),
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
                                  controller: imgtextcontroller,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      hintText:
                                          ' Enter the prompt of the image',
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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 253, 252, 250),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                alignment: Alignment.center,
                                dropdownColor:
                                    Color.fromARGB(255, 241, 241, 239),
                                value: dropvalue,
                                hint: Text(" Select Size"),
                                items: List.generate(
                                    sized.length,
                                    (index) => DropdownMenuItem(
                                          child: Text(options[index]),
                                          value: sized[index],
                                        )),
                                onChanged: (value) {
                                  setState(() {
                                    dropvalue = value.toString();
                                  });
                                })),
                      )
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
                            if (imgtextcontroller.text.isNotEmpty &&
                                dropvalue!.isNotEmpty) {
                              waiting =
                                  'Please wait while your image is being generated';
                              setState(() {
                                isloading = false;
                              });
                              imaged = await ImgApi.generateImage(
                                  imgtextcontroller.text, dropvalue!);
                              setState(() {
                                isloading = true;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Prompt or Size missing'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Text(
                            'Generate Image',
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
    );
  }
}
