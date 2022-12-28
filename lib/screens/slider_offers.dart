import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/screens/offer_detail.dart/offer_detail.dart';
import '../../models/serializable_model/offer.dart';
import '../../net/http_client.dart';
import '../components/AppColors.dart';
import '../components/ProviderItem.dart';
import '../components/MyAppBar.dart';

class ProviderOffersFromHomePage extends ModalRoute<void> {
  final int serviceid;

  ProviderOffersFromHomePage({required this.serviceid});

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

  List<bool> isSelected = [true, false, false];

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.app_bg,
      appBar: MyAppBar(title: 'Service Provide List'),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("House Cleaning",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hire a house cleaner to clean your kitchen, hall, lawn and washroom",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.title_desc,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Recommended for you",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, position) {
                  return ItemServicesCard();
                }
                ,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                )
                ,
              ),
            ),
          ],
        ),
      )
    );
  }
}
