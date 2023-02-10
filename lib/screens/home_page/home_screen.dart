// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/screens/chats/all_chat_screen.dart';
import 'package:kappu/screens/home_page/widgets/slider.dart';
import 'package:kappu/screens/login/login_screen.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<ProviderProvider>(context);

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
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Row(
                        children: [
                          Image.asset('assets/icons/location.png', scale: 1.0),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,2,2,2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Current Location",
                                    style: TextStyle(
                                        color: AppColors.title_desc,
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.w500)),
                                Text("Germany",
                                    style: TextStyle(
                                        color: AppColors.text_desc,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                                // radius: 30,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    print(provider.token);

                                    if(provider.token !=null) {
                                      pushDynamicScreen(context,
                                          screen: SettingsPage(),
                                          withNavBar: false);
                                    }else{
                                      pushDynamicScreen(context,
                                          screen: LoginScreen(),
                                          withNavBar: false);

                                    }
                                  },
                                  icon: const Icon(
                                    Icons.account_circle_outlined,
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
                    height: ScreenUtil().setHeight(15),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(8)),
                    child: SearchTextField(
                      hintext: "Search Services",
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
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Services',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(21)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:
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
