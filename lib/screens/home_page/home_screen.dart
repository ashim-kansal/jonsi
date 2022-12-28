// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/screens/chats/all_chat_screen.dart';
import 'package:kappu/screens/home_page/widgets/slider.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// import '../../constants/services.dart';
import '../notification/notifications.dart';
import 'widgets/search_text_field.dart';
import 'widgets/services_container.dart';
import 'widgets/services_horizontal_slider.dart';

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
            Container(
              height: ScreenUtil().setHeight(170),
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current Location",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w500)),
                                Text("Germany",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(50),
                          ),
                          // CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     child: IconButton(
                          //       onPressed: () {
                          //         pushDynamicScreen(context,
                          //             screen: NotificationsPage(),
                          //             withNavBar: false);
                          //       },
                          //       icon: const Icon(
                          //         Icons.notifications,
                          //         color: Colors.blue,
                          //       ),
                          //     )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    pushDynamicScreen(context,
                                        screen: AllChatScreen(),
                                        withNavBar: false);
                                  },
                                  icon: const Icon(
                                    Icons.message,
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                                // radius: 30,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    pushDynamicScreen(context,
                                        screen: SettingsPage(),
                                        withNavBar: false);
                                  },
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(15),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(17),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(8)),
                    child: SearchTextField(
                      hintext: "Search A Service",
                      onSearchingComplete: () {},
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const SliderWidget(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(8),
                        bottom: ScreenUtil().setHeight(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.00),
                          child: Text(
                            'Services',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(21)),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 20),
                        //   child: Text(
                        //     'See all',
                        //     style: TextStyle(
                        //         color: Colors.blue,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: "Radomir Tinkov",
                        //         fontSize: ScreenUtil().setSp(20)),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(4), bottom: 10),
                    child:
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.12,
                        //   child: ListView(
                        //     scrollDirection: Axis.horizontal,
                        //     physics: const ScrollPhysics(),
                        //     children: servicesSummary
                        //         .map((item) => Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(20),
                        //                     border: Border.all(color: Colors.grey)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Column(children: [
                        //                     Image.asset(
                        //                       item.imagepath,
                        //                       height: ScreenUtil().setHeight(40),
                        //                     ),
                        //                     Text(item.servicename,
                        //                         style: TextStyle(
                        //                             color: Colors.grey,
                        //                             fontSize:
                        //                                 ScreenUtil().setSp(14),
                        //                             fontWeight: FontWeight.w500))
                        //                   ]),
                        //                 ),
                        //               ),
                        //             ))
                        //         .toList(),
                        //   ),
                        // )
                        const Servicescontainer(),
                  ),
                  // Divider(
                  //   thickness: 5,
                  //   color: Colors.grey.shade300,
                  // ),
                  // const ServicesSliderHorizontal(),
                  // const OurBestServices(),
                  const SizedBox(height: 45)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
