import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/bookings/booking_screen.dart';
import 'package:kappu/screens/catagories/catagories_screen.dart';
import 'package:kappu/screens/notification/notification_screen.dart';
import 'package:kappu/screens/notification/notifications.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../screens/ProviderScreens/all_chats.dart';
import '../screens/ProviderScreens/notification/notifications.dart';
import '../screens/ProviderScreens/settings/settings_screen.dart';
import '../screens/home_page/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  final bool isprovider;

  const BottomNavBar({Key? key, required this.isprovider}) : super(key: key);

  // final BuildContext menuScreenContext;
  // BottomNavBar({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late BuildContext testContext;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  Future<void> uidisnull() async {}

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CatagoriesScreen(),
      const NotificationScreen(),
      const BookingScreen(),
    ];
  }

  List<Widget> _buildScreensprovider() {
    return [
      const ProviderHomeScreen(),
      const AllChatsScreenProvider(),
      const NotificationsPageProvider(),
      const BookingScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItemsprovider() {
    return [

      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_outlined,
        ),
        title: "Home",
        textStyle: const TextStyle(),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.messenger),
        title: ("Chats"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: ("Notification"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.book_rounded,
        ),
        title: "Bookings",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_outlined,
        ),
        title: "Home",
        textStyle: const TextStyle(),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.article_outlined),
        title: ("Catagories"),
        textStyle: const TextStyle(),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: ("Notification"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book_rounded),
        title: ("Bookings"),
        textStyle: const TextStyle(),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: widget.isprovider ? _buildScreensprovider() : _buildScreens(),
      items: widget.isprovider ? _navBarsItemsprovider() : _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      hideNavigationBarWhenKeyboardShows: true,
      popActionScreens: PopActionScreensType.all,
      onWillPop: (context) async {
        await showDialog(
          context: context!,
          useSafeArea: true,
          builder: (context) => Container(
            height: 50.0,
            width: 50.0,
            color: Colors.white,
            child: ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                exit(0);
              },
            ),
          ),
        );
        return false;
      },
      selectedTabScreenContext: (context) {
        testContext = context!;
      },
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
