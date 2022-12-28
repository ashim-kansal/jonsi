import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../slider_offers.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final List imgList = [
    ['Feeling ill!', 'assets/images/doctor.jpg', 'Book your doctor', 1],
    ['Need to go out!', 'assets/images/escotter.jpg', 'Get your E-Scotter', 3],
    [
      'Need Plumbing Service!',
      'assets/images/plumber.jpg',
      'Call Plumber Now',
      2
    ],
    ['Feeling tired!', 'assets/images/massagewomen.jpg', 'Book A massager', 4],
    ['Need a glow!', 'assets/images/saloonwomen.jpg', 'Saloon for Women', 5],
    ['Need a haircut!', 'assets/images/barber.jpg', 'Book a hair dresser', 6],
    [
      'Need Baby Sitter!',
      'assets/images/babysitter.jpg',
      'Call a baby sitter',
      7
    ],
    [
      'Need to Clean home!',
      'assets/images/homecleaning.jpg',
      'Call your Home Cleaner',
      8
    ],
    [
      'Need Electrical Assistant!',
      'assets/images/electrician.jpg',
      'Call Electrician at your Home',
      9
    ],
    [
      'Going to gym!',
      'assets/images/fitness.jpg',
      'Book A Fitness Coach Now',
      10
    ],
    [
      'Your pet feeling ill!',
      'assets/images/vetdoctor.jpg',
      'Get a Vet Doctor Service Now',
      11
    ],
    ['Need a Lock', 'assets/images/lock.jpg', 'Call a LockSmith Now', 12],
    [
      'Stuck in some Case!',
      'assets/images/lawyer.jpg',
      'Book A Lawyer For Your Case',
      13
    ],
    [
      'Issue with bicycle!',
      'assets/images/bycyclemechenic.jpg',
      'Get A Bicycle Mechenic',
      14
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: ScreenUtil().setHeight(220),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          // image: DecorationImage(
          //     image: AssetImage(
          //       'assets/images/background.jpg',
          //     ),
          //     fit: BoxFit.cover),
        ),
        child:
            //  Container(
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //   child: CarouselSliderWidget(
            //     options: CarouselOptions(autoPlay: true),
            //     items: imgList
            //         .map((item) => Center(
            //             child:
            //                 Image.network(item, fit: BoxFit.cover, width: 1000)))
            //         .toList(),
            //   ),
            // )),
            CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.easeInOutBack,
              autoPlayInterval: const Duration(seconds: 3)),
          items: imgList
              .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      pushDynamicScreen(context,
                          screen:
                              ProviderOffersFromHomePage(serviceid: item[3]),
                          withNavBar: false);
                    },
                    child: Stack(
                      children: [
                        Container(
                            height: ScreenUtil().setHeight(170),
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.darken),
                                image: AssetImage(
                                  item[1],
                                ),
                              ),
                            )),
                        // Center(
                        //     child: Image.asset(
                        //   item[0],
                        //   fit: BoxFit.cover,
                        // )),
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item[0],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  item[2],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(50),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(28),
                                width: ScreenUtil().setWidth(90),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(13)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )))
              .toList(),
        ));
  }
}
