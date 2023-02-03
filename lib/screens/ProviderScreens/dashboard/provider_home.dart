import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/register/social_signup.dart';

import 'widget/custom_toggle_button.dart';
import 'widget/earning_item.dart';
import 'widget/home_item.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
                padding:
                    EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 15),
                color: Colors.blue,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 1.4),
                    ),
                  ],
                )),
            Divider(
              height: 0.5,
              color: Colors.white,
            ),
            Container(
              color: Colors.blue,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    CircleAvatar(
                      radius: ScreenUtil().setHeight(30),
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: ScreenUtil().setWidth(250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "john wing",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4),
                            ),
                            Text(
                              "johnwing@gmail.com",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,

                              itemPadding:
                              EdgeInsets.only(right: 2),
                              itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              'Current Balance : ',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seller mode  ",
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            CustomToggleButton(
                              isSelected: true,
                              onChange: (value) {},
                            )
                          ],
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      children: const [
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                        const SizedBox(width: 20),
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                        const SizedBox(width: 20),
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                        const SizedBox(width: 20),
                        Expanded(
                            child: HomeItem(
                          title: 'Earnings',
                          imagePath: 'assets/images/ic_earning.jpg',
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Earnings",
                      style: TextStyle(
                          color: AppColors.app_color,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: EarningItem(
                                    title: '\$0',
                                    subTitle: 'Personal Balance',
                                    titleColor: AppColors.app_color,
                                  )),
                                  Expanded(
                                      child: EarningItem(
                                    title: '\$0',
                                    subTitle: 'Total Bookings',
                                    titleColor: AppColors.app_black,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: EarningItem(
                                    title: '\$0',
                                    subTitle: 'Earning this month',
                                    titleColor: AppColors.app_black,
                                  )),
                                  Expanded(
                                      child: Expanded(
                                          child: EarningItem(
                                    title: '\$0',
                                    subTitle: 'Avg. Selling Price',
                                    titleColor: AppColors.app_black,
                                  )))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: EarningItem(
                                    title: '\$0',
                                    showDivider: false,
                                    subTitle: 'Active Order',
                                    titleColor: AppColors.app_black,
                                  )),
                                  Expanded(
                                      child: EarningItem(
                                    title: '\$0',
                                    showDivider: false,
                                    subTitle: 'Cancel Order',
                                    titleColor: AppColors.app_black,
                                  ))
                                ],
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Current Rating",
                      style: TextStyle(
                          color: AppColors.app_black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total Rating",
                                style: TextStyle(
                                    color: AppColors.app_black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),

                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,

                                    itemPadding:
                                        EdgeInsets.only(right: 2),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}