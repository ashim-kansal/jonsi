import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/edit_profile/edit_profile.dart';
import 'package:kappu/screens/faqs/frequently_asked_questions.dart';
import 'package:kappu/screens/privacy_policy/privacy_policy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../helperfunctions/screen_nav.dart';

class SettingsPage extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }


  TextEditingController searchController = TextEditingController();
  late int cardViewed;
  bool alreadyowned = false;
  Widget _buildOverlayContent(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'Setting'),
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, loggedinuser, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                      backgroundImage:  NetworkImage(
                          'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Wing', style: TextStyle(fontFamily: "Montserrat-Bold", fontSize: 18, color: Colors.black),),
                      Text('Johnwing@gmail.com', style: TextStyle(fontFamily: "Montserrat-Regular", fontSize: 12, color: AppColors.text_desc),),
                      10.verticalSpace,
                      Text('+356 0382 7535', style: TextStyle(fontFamily: "Montserrat-Regular", fontSize: 12, color: AppColors.text_desc),),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: RawMaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      fillColor: AppColors.app_color,
                      child: Icon(
                        Icons.edit,
                        size: 16.0,
                        color: Colors.white,
                      ),
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),),
              ProfileItemTitle(label: "Account Setting"),
              ProfileItem(label: "Change Password", iconPath: 'assets/icons/loc.png', onTap: (){
                print("change pasworhhh   jd");
              }),
              ProfileItem(label: "Logout", iconPath: 'assets/icons/loc.png'),
              ProfileItemTitle(label: "General"),
              ProfileItem(label: "Add GIG", iconPath: 'assets/icons/loc.png'),
              ProfileItem(label: "GIGs Offered", iconPath: 'assets/icons/loc.png'),
              ProfileItem(label: "Faq’s", iconPath: 'assets/icons/loc.png', onTap: (){
                    changeScreen(
                    context: context,
                screen: FrequentlyAskedQuestions(title: "Faq's",));
              }),
              ProfileItem(label: "Notifications", iconPath: 'assets/icons/loc.png'),
              ProfileItem(label: "Privacy Policy", iconPath: 'assets/icons/loc.png'),
              ProfileItem(label: "Services Completed", iconPath: 'assets/icons/loc.png'),
              ProfileItem(label: "Total Ratings and Reviews", iconPath: 'assets/icons/loc.png'),
              ProfileItemTitle(label: "Support"),
              ProfileItem(label: "Help Center", iconPath: 'assets/icons/loc.png'),

              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}