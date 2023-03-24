import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/bookings/booking_screen.dart';
import 'package:kappu/screens/catagories/catagories_screen.dart';
import 'package:kappu/screens/login/login_screen.dart';
import 'package:kappu/screens/notification/notification_screen.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
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

            if(i>1 && StorageManager().accessToken.isNullOrEmpty)
              bottomSheetForSignIn(context, i);

          });
        },
        items: widget.isprovider
            ? [
                bmnav.BottomNavItem('assets/icons/home.png', label: ''),
                bmnav.BottomNavItem('assets/icons/notification.png', label: ''),
                bmnav.BottomNavItem('assets/icons/booking.png', label: ''),
                bmnav.BottomNavItem('assets/icons/ic_settings.png', label: ''),
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
              SettingsPage(),
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

  bottomSheetForSignIn(BuildContext context, int type) {
    showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height-50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),child:LoginScreen(isFromOtherScreen: true));
        }
    ).whenComplete(() {
      print('complete');
      if(StorageManager().accessToken.isNotNullAndNotEmpty) {
        if (type == 1) {
          return NotificationScreen();
        } else {
          return BookingScreen();
        }
      }else{
        setState(() {
          currentTab = 0;
          currentScreen = HomeScreen();
        });
      }
    }
    ).catchError((onError){
      print(onError);
    });
  }


}
