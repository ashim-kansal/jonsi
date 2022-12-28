import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/serializable_model/offer.dart';

class OfferDetail extends ModalRoute<void> {
  final Offers offer;

  OfferDetail({required this.offer});
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
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  double totalprice = 0;
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(35), left: ScreenUtil().setWidth(15)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              20.horizontalSpace,
              Text(
                "Offer Detail",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(22)),
              ),
            ],
          ),
        ),
        20.verticalSpace,
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              // height: ScreenUtil().setHeight(1200),
              width: double.infinity,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(25), bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              offer.offertitle,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(16)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade800,
                          ),
                          Text(
                            ' 4.6  ',
                            style: TextStyle(
                                color: Colors.yellow.shade800,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(14)),
                          ),
                          Text(
                            '(21)',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(14)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      const Divider(thickness: 1),
                      ListView(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: offer.packages
                              .map((item) => Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.packagetitle,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(16)),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          r" $"
                                          '${item.packagePrice.toString()}'
                                          '     \u2022 ${item.packageServicetime}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(14)),
                                        ),
                                        10.verticalSpace,
                                        Center(
                                          child: Card(
                                            elevation: 2,
                                            child: Container(
                                              height: 30.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                              
                                                },
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        5.verticalSpace,
                                        const Divider(thickness: 1)
                                      ],
                                    ),
                                  ))
                              .toList()),
                    
                      Center(
                        child: TextButton(
                            onPressed: () {
                              
                            },
                            child: const Text('+ Add package')),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(4)),
                      Text(
                        'The motivation of our project is to provide people with an easy-to-use app where users can book/buy and sell services. Currently all service provider apps are owned by large companies.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            height: 1.4),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),

                      SizedBox(height: ScreenUtil().setHeight(40)),
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
