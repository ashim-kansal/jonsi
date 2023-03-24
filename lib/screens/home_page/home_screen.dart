import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/catagories/search_catagories_screen.dart';
import 'package:kappu/screens/home_page/widgets/best_services.dart';
import 'package:kappu/screens/home_page/widgets/slider.dart';
import 'package:kappu/screens/login/login_screen.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'widgets/search_text_field.dart';
import 'widgets/services_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30,
                        color: AppColors.app_color,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Current location',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff7B7D83)),
                          ),
                          Text(
                            'Malta',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff7B7D83)),
                          )
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                            // radius: 30,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                if (StorageManager().accessToken.isNotEmpty) {
                                pushDynamicScreen(context,
                                    screen: SettingsRoutePage(), withNavBar: false);
                                } else {
                                  bottomSheetForSignIn(context);
                                }
                              },
                              icon: const Icon(
                                Icons.account_circle_outlined,
                                color: AppColors.app_color,
                                size: 30,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                // const SizedBox(height: 5,),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       'assets/images/colorfulLogo.png',
                //       width: MediaQuery.of(context).size.width * 0.14,
                //       height: MediaQuery.of(context).size.height * 0.05,
                //     ),
                //     Text(
                //       'URBAN MALTA',
                //       style: TextStyle(
                //           fontSize: 22,
                //           color: AppColors.app_color,
                //           fontWeight: FontWeight.bold),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const SearchCatagoriesScreen()));
                      },
                      child: SearchTextField(
                        enable: false,
                        hintext: "Search Services",
                        onSearchingComplete: (value) {},
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),

            /*Container(
              height: ScreenUtil().setHeight(160),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Row(children: [
                      Image.asset(
                        'assets/images/colorfulLogo.png',
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(5, 2, 2, 2.0),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text("Current Location",
                      //           style: TextStyle(
                      //               color: AppColors.title_desc,
                      //               fontSize: ScreenUtil().setSp(10),
                      //               fontWeight: FontWeight.w500)),
                      //       Text("Germany",
                      //           style: TextStyle(
                      //               color: AppColors.text_desc,
                      //               fontSize: ScreenUtil().setSp(14),
                      //               fontWeight: FontWeight.w500))
                      //     ],
                      //   ),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                            // radius: 30,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                // if (StorageManager().accessToken.isNotEmpty) {
                                pushDynamicScreen(context,
                                    screen: SettingsPage(), withNavBar: false);
                                // } else {
                                //   changeScreen(
                                //       context: context,
                                //       screen: LoginScreen(isFromOtherScreen: true));
                                // }
                              },
                              icon: const Icon(
                                Icons.account_circle_outlined,
                                color: AppColors.app_color,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6)),
                    child: SearchTextField(
                      hintext: "Search Services",
                      onSearchingComplete: () {},
                    ),
                  )
                ],
              ),
            ),*/
            Expanded(
                child: Container(
              color: AppColors.color_f2f7fd,
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      20.verticalSpace,
                      const SliderWidget(),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 20, bottom: 5),
                        child: Text(
                          'Popular Services',
                          style: TextStyle(
                              color: AppColors.app_color,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(21)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 5),
                        child: const OurBestServices(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 20, bottom: 5),
                        child: Text(
                          'Best Services',
                          style: TextStyle(
                              color: AppColors.app_color,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(21)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: const Servicescontainer(),
                      ),
                      const SizedBox(height: 45),
                      const SizedBox(height: 45),
                    ],
                  )),
            )),
          ],
        ),
      ),
    );
  }

  bottomSheetForSignIn(BuildContext context)
  {
    showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height-50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),child:LoginScreen(isFromOtherScreen: true));

        }
    ).whenComplete(() {
        print('ondismiss');
        if(StorageManager().accessToken.isNotNullAndNotEmpty)
          pushDynamicScreen(context,
            screen: SettingsRoutePage(), withNavBar: false);

    }
    );
  }
}
