import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/service_summary.dart';
import '../../models/serializable_model/offer.dart';
import '../../net/http_client.dart';
import '../offer_detail.dart/offer_detail.dart';

class ProviderOffers extends ModalRoute<void> {
  final ServiceSummary service;

  ProviderOffers({required this.service});
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
      body: Column(
        children: <Widget>[
          Container(
            height: 90.h,
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 35.w),
              child: Row(children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.w),
                  child: Text(
                    service.servicename,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp),
                  ),
                ),
              ]),
            ),
          ),
          FutureBuilder(
              future: HttpClient().getoffersbycatagory(service.id),
              builder: (context, AsyncSnapshot<List<Offers>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Padding(
                    padding: EdgeInsets.only(top: 260.h),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 260.h),
                    child: Text(
                      'NO OFFERS YET FOR THIS CATAGORY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                      padding: EdgeInsets.only(top: 12.h),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: snapshot.data!
                          .map(
                            (item) => Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                                child: Column(
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.userfirstname +
                                                    " " +
                                                    item.userlastname,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Radomir Tinkov',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 20.h,
                                            backgroundImage: const NetworkImage(
                                              'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                            ),
                                          )
                                        ]),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.offertitle,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Radomir Tinkov',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color:
                                                        Colors.yellow.shade800,
                                                  ),
                                                  Text(
                                                    item.reviewcount == 0
                                                        ? ' Not rated yet'
                                                        : item.averagerating
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Radomir Tinkov',
                                                        color: Colors
                                                            .yellow.shade800,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp),
                                                  ),
                                                  if (item.reviewcount != 0)
                                                    Text(
                                                      ' (${item.reviewcount.toString()})',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Radomir Tinkov',
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp),
                                                    ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                "Includes ${item.packages.length} packages",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Radomir Tinkov',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Divider(
                                                  thickness: 1,
                                                ),
                                              ),
                                              Text(
                                                item.offerDescription,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Radomir Tinkov',
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showofferdetail(
                                                        context: context,
                                                        offer: item);
                                                  },
                                                  child: const Text(
                                                    'View service Details',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Radomir Tinkov',
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 130.h,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  'assets/images/livingroomcleaning.jpg',
                                                  height: 100.h,
                                                  width: 100.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 15.h,
                                                  left: 5,
                                                  child: Card(
                                                    elevation: 2,
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          "Add",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Radomir Tinkov',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    )
                                  ],
                                )),
                          )
                          .toList()),
                );
              }),
        ],
      ),
    );
  }
}
