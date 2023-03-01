import 'package:flutter/material.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/bookings/booking_screen.dart';
import 'package:kappu/screens/catagories/catagories_screen.dart';
import 'package:kappu/screens/notification/notification_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../common/bmnav.dart' as bmnav;
import '../screens/ProviderScreens/all_chats.dart';
import '../screens/ProviderScreens/notification/notifications.dart';
import '../screens/home_page/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  final bool isprovider;

  const BottomNavBar({Key? key, required this.isprovider}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late BuildContext testContext;

  int currentTab = 0;
  List<Widget> screens = [];
  Widget? currentScreen;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _buildHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      body: PageStorage(child: currentScreen!, bucket: bucket),
      bottomNavigationBar: bmnav.BottomNav(
        index: currentTab,
        labelStyle: bmnav.LabelStyle(visible: true),
        onTap: (i) {
          setState(() {
            currentTab = i;
            currentScreen = screens[i];
          });
        },
        items: widget.isprovider
            ? [
                bmnav.BottomNavItem('assets/icons/home.png', label: ''),
                bmnav.BottomNavItem('assets/icons/notification.png', label: ''),
                bmnav.BottomNavItem('assets/icons/booking.png', label: ''),
              ]
            : [
                bmnav.BottomNavItem('assets/icons/home.png', label: ''),
                bmnav.BottomNavItem('assets/icons/catagory.png', label: ''),
                bmnav.BottomNavItem('assets/icons/notification.png', label: ''),
                bmnav.BottomNavItem('assets/icons/booking.png', label: ''),
              ],
      ),
    );
  }

  void _buildHome() {
    setState(() {
      screens = widget.isprovider
          ? [
              const ProviderHomeScreen(),
              const NotificationScreen(),
              const BookingScreen(),
            ]
          : [
              const HomeScreen(),
              const CatagoriesScreen(),
              const NotificationScreen(),
              const BookingScreen(),
            ];
      currentScreen =
          widget.isprovider ? const ProviderHomeScreen() : const HomeScreen();
    });
  }
}
