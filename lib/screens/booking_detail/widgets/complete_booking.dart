import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/booking_action_button.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/screens/add_review/add_review.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../net/http_client.dart';
import '../../../provider/userprovider.dart';

completebottomsheet(
    BuildContext context, Booking booking, Function setbookingstate) async {
  bool completing = false;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              20.verticalSpace,
              Text(
                'Confirmation',
                style: TextStyle(
                    fontFamily: 'Montserrat-Bold',
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                child: Text(
                  'The Service Provider ${booking.providerfname + " " + booking.providerlname} has provided you ${booking.boughtpackages.first.package.packagetitle}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: StatefulBuilder(builder: (context, setstate) {
                  return Column(
                    children: [
                      Consumer<UserProvider>(
                        builder: (context, loggedinuser, child) =>
                            CustomBookingButton(
                          isLoading: completing,
                          buttontext: 'Cofirm Complete',
                          color: Colors.green,
                          onPressed: () async {
                            if (!completing) {
                              completing = true;
                              setstate(() {});
                              Map<String, dynamic> body = {
                                "is_completed": true
                              };
                              await HttpClient()
                                  .acceptrejectbookingrequest(booking.id, body)
                                  .then((value) {
                                completing = false;

                                setbookingstate();
                                Navigator.pop(context);
                                pushDynamicScreen(context,
                                    screen: AddReview(booking: booking, setbookingstate: setbookingstate), withNavBar: false);
                              }).catchError((e) {
                                completing = false;
                                setstate(() {});
                              });
                            }
                          },
                        ),
                      ),
                      CustomBookingButton(
                        isLoading: false,
                        buttontext: 'Cancel',
                        color: Colors.red,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }),
              )
            ]),
          ),
        );
      });
}
