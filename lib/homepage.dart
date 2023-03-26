import 'package:aichat/imageai/imagepage.dart';
import 'package:aichat/indexpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5.0,
            // // shadowColor: Colors.amberAccent,
            // bottom: TabBar(
            //   tabs: [
            //     Tab(
            //       icon: Icon(Icons.chat_bubble),
            //       text: "Chat",
            //     ),
            //     Tab(icon: Icon(Icons.image_rounded), text: "Image"),
            //   ],
            // ),
            actions: [
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: InkWell(onTap: () {}, child: Icon(Icons.info_outline)))
            ],
            title: Text('AskMe AI'),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(20)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "Chat",
                      ),
                      Tab(text: "Image"),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    Center(child: indexpage()),
                    Center(child: ImagePage()),
                  ],
                ))
              ],
            ),
          )
          //
          // TabBarView(
          //   children: [
          //     Center(child: indexpage()),
          //     Center(child: ImagePage()),
          //   ],
          ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
