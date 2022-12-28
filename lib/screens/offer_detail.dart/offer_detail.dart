import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/models/user_offer.dart';
import '../../models/serializable_model/offer.dart';
import '../selectservicelocation/servicelocation.dart';

dynamic showofferdetail(
    {required BuildContext context, required Offers offer}) {
  bool showproceed = false;
  double totalpackageprice = 0.0;
  UserOffer userOffer = UserOffer(
      userofferid: '', packages: [], date: '', time: '', totalprice: 0);

  return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: StatefulBuilder(builder: (context, StateSetter setter) {
            for (int i = 0; i < offer.packages.length; i++) {
              if (offer.packages[i].packageservicequantity > 0) {
                showproceed = true;
                break;
              } else {
                showproceed = false;
              }
            }
            return Stack(
              children: [
                Column(children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      offer.offertitle,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
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
                                        fontSize: 14.sp),
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
                              20.verticalSpace,
                              const Divider(thickness: 1),
                              ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: offer.packages
                                      .map((item) => Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.packagetitle,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  r" $"
                                                  '${item.packagePrice.toString()}'
                                                  '     \u2022 ${item.packageServicetime}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp),
                                                ),
                                                20.verticalSpace,
                                                item.packageservicequantity == 0
                                                    ? Center(
                                                        child: Card(
                                                          elevation: 2,
                                                          child: SizedBox(
                                                            height: 30.h,
                                                            width: 100.w,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                item.packageservicequantity++;
                                                                totalpackageprice +=
                                                                    item.packagePrice;
                                                                userOffer
                                                                    .packages
                                                                    .add(item);
                                                                setter(
                                                                    () => {});
                                                              },
                                                              child: Text(
                                                                "Add",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                            Card(
                                                              elevation: 2,
                                                              child: SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 18,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      item.packageservicequantity--;
                                                                      totalpackageprice -=
                                                                          item.packagePrice;
                                                                      setter(() =>
                                                                          {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            10.horizontalSpace,
                                                            Text(
                                                              item.packageservicequantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Card(
                                                              elevation: 2,
                                                              child: SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      size: 18,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      item.packageservicequantity++;
                                                                      totalpackageprice +=
                                                                          item.packagePrice;
                                                                      setter(() =>
                                                                          {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(10)),
                                                const Divider(thickness: 1)
                                              ],
                                            ),
                                          ))
                                      .toList()),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(4)),
                              Text(
                                offer.offerDescription,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4),
                              ),
                            ]),
                      ),
                    ),
                  )
                ]),
                if (showproceed)
                  Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.white,
                        height: 70.h,
                        width: 350.w,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Padding(
                            padding: EdgeInsets.all(15.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    r'  $'
                                    '$totalpackageprice',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(20)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40.w),
                                    child: GestureDetector(
                                      onTap: () async {
                                        changeScreen(
                                            context: context,
                                            screen: SelectServiceLocation(
                                              offer: offer,
                                            ));
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 150.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Proceed',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ))
              ],
            );
          }),
        );
      });
}
