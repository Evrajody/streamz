import 'package:flutter/material.dart';
import 'package:streamz/screen/streams_download.dart';
import 'package:streamz/screen/streamz_main.dart';
import 'package:streamz/screen/streamz_search.dart';
import 'package:streamz/screen/streamz_user_profile.dart';
import 'package:streamz/tools/streamz_constants.dart';

class StreamzHome extends StatefulWidget {
  const StreamzHome({Key? key}) : super(key: key);

  @override
  State<StreamzHome> createState() => _StreamzHomeState();
}

class _StreamzHomeState extends State<StreamzHome> {
  int selectedIndex = 0;
  PageController maincontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          StreamzMain(),
          StreamzSearch(),
          StreamzDownload(),
          StreamzUserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25.5,
        elevation: 3.5,
        currentIndex: selectedIndex,
        showSelectedLabels: false,
        unselectedIconTheme: const IconThemeData(opacity: 0.5),
        selectedIconTheme: const IconThemeData(opacity: 1),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: List.generate(
          navbarTools.length,
          (index) => BottomNavigationBarItem(
            backgroundColor: erieBlack,
            icon: navbarTools[index]["icon"],
            label: navbarTools[index]['label'],
          ),
        ),
      ),
    );
  }
}
