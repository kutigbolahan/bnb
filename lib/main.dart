import 'dart:io';

import 'package:bottomnav/faq.dart';
import 'package:bottomnav/junk.dart';
import 'package:bottomnav/mainScreen.dart';
import 'package:bottomnav/profile.dart';
import 'package:bottomnav/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [MainScreen(), SettingsScreen(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      onItemSelected: (int index) async {
        if (index == 2) {
          print(3);
          await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(1000.0, 600.0, 0, 0),
              items: <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    child: GestureDetector(
                      onTap: () {
                        Platform.isIOS
                            ? Navigator.of(context).push(CupertinoPageRoute(
                                builder: (BuildContext context) => Faq()))
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Faq()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person, color: Colors.red),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Faq',
                          )
                        ],
                      ),
                    ),
                    value: 'test1'),
                new PopupMenuItem<String>(
                    child: GestureDetector(
                      onTap: () {
                        Platform.isIOS
                            ? Navigator.of(context).push(CupertinoPageRoute(
                                builder: (BuildContext context) => Junk()))
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Junk()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person, color: Colors.red),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Junk',
                          )
                        ],
                      ),
                    ),
                    value: 'test2'),
              ]);
        }
      },
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }
}
