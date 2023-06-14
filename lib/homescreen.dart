
import 'package:aichat/screens/chat_screen.dart';
import 'package:aichat/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'imagepage.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
      
          appBar: MyAppBar(),
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
                        color: Theme.of(context).colorScheme.secondary,
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
                    Center(child: ChatScreen()),
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