import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/screens/ProviderScreens/item_recommended.dart';
import 'package:kappu/screens/ProviderScreens/item_review.dart';
import 'package:kappu/screens/ProviderScreens/order_review.dart';

import '../../models/serializable_model/provider_detail_model.dart';
import '../../net/http_client.dart';

class ProviderDetailScreen extends StatefulWidget {
  final int id;

  ProviderDetailScreen({required this.id});

  @override
  _ProviderDetailScreenState createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.app_bg,
        body: FutureBuilder(
            future: HttpClient().getServiceProviderDetail("${widget.id}"),
            builder:
                (context, AsyncSnapshot<List<ProviderDetailModel>> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  color: AppColors.color_f2f7fd,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            child: getDataImage(response.data![0].gigdocument!),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20, top: 50),
                              child: CircleAvatar(
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
                                  ))),
                        ],
                      ),
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: ScreenUtil().setHeight(30),
                                  backgroundImage: NetworkImage(''),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      response.data![0].userData != null &&
                                              response.data![0].userData!
                                                      .firstName !=
                                                  null
                                          ? '${response.data![0].userData!.firstName!} '
                                              '${response.data![0].userData!.lastName!}'
                                          : '',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Montserrat-Bold'),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              response.data![0].rating!),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          ignoreGestures: true,
                                          itemPadding:
                                              EdgeInsets.only(right: 0.1),
                                          itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: AppColors.app_yellow),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                          ' ${response.data![0].rating}',
                                          style: TextStyle(fontSize: 14.sp, color: AppColors.app_yellow, fontFamily: "Montserrat-bold"),
                                        ),Text(
                                          ' (0 Rating)',
                                          style: TextStyle(fontSize: 10.sp, color: AppColors.text_desc,
                                              fontFamily: "Montserrat-regular"
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                          5.verticalSpace,
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                response.data![0].title!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat-Bold'),
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(10,0,10,10),
                              child: Text(
                                response.data![0].description!,
                                style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat-Regular'),
                              )),
                          Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat-Regular'),
                                      ),
                                      Text(
                                        response.data![0].servicepackages!=null ? response.data![0].servicepackages!.location ?? "" : "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat-SemiBold'),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Member Joined',
                                        style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat-Regular'),
                                      ),
                                      Text(
                                        'Dec 2020',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat-SemiBold'),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'desc',
                                  //   style: TextStyle(
                                  //       color: Colors.grey,
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.normal),
                                  // ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('Hourly Price',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: "Montserrat-Bold"))),
                                      Text(
                                          response.data![0].servicepackages !=
                                                  null
                                              ? '\$ ${response.data![0].servicepackages!.price!}'
                                              : '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: "Montserrat-Bold")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().screenHeight * 0.06,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                              .screenHeight *
                                                          0.035)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Opacity(
                                            opacity: 0,
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                          ),
                                          Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontFamily: 'Montserrat-Medium',
                                            ),
                                          ),
                                          Image.asset('assets/icons/arw.png',
                                              scale: 1.0),
                                        ],
                                      ),
                                      onPressed: () {
                                        Map<String, dynamic> map = {
                                          'name': response.data![0].title,
                                          'desc': response.data![0].description,
                                          'price': response
                                              .data![0].servicepackages!.price,
                                          // 'image': response.data![0].gigdocument![0].fileName ?? "",
                                          'location': response.data![0]
                                              .servicepackages!.location,
                                          'provider_id':
                                              response.data![0].userId,
                                          'service_id': response.data![0].id,
                                        };

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderReview(
                                                      bodyprovider: map,
                                                    )));
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                RatingBar.builder(
                                  initialRating:
                                      response.data![0].ratingCount != null
                                          ? double.parse(
                                              response.data![0].ratingCount!)
                                          : 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  ignoreGestures: true,
                                  itemPadding: EdgeInsets.only(right: 0.1),
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: AppColors.app_yellow),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Text(
                                  ' ${response.data![0].ratingCount != null
                                      ? double.parse(
                                      response.data![0].ratingCount!)
                                      : 3}',
                                  style: TextStyle(fontSize: 14.sp, color: AppColors.app_yellow, fontFamily: "Montserrat-bold"),
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(20),
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xff4995EB).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('5 Stars',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:'Montserrat-Bold'))),
                                      Text('20 Reviews',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 10,
                                            fontFamily: 'Montserrat-Regular')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    value: 20,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('5 Stars',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:'Montserrat-Bold'))),
                                      Text('20 Reviews',
                                          style: TextStyle(
                                              color: AppColors.text_desc,
                                              fontSize: 10,
                                              fontFamily: 'Montserrat-Regular')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    value: 0.8,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('5 Stars',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:'Montserrat-Bold'))),
                                      Text('20 Reviews',
                                          style: TextStyle(
                                              color: AppColors.text_desc,
                                              fontSize: 10,
                                              fontFamily: 'Montserrat-Regular')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    value: 20,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('5 Stars',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:'Montserrat-Bold'))),
                                      Text('20 Reviews',
                                          style: TextStyle(
                                              color: AppColors.text_desc,
                                              fontSize: 10,
                                              fontFamily: 'Montserrat-Regular')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    value: 20,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('5 Stars',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:'Montserrat-Bold'))),
                                      Text('20 Reviews',
                                          style: TextStyle(
                                              color: AppColors.text_desc,
                                              fontSize: 10,
                                              fontFamily: 'Montserrat-Regular')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    value: 20,
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 5, top: 10),
                            child: Text(
                              response.data![0].reviewCount!.toString(),
                              style: TextStyle(
                                  color: Color(0xffF79E1F),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 0),
                            height: 145,
                            child: SizedBox(
                                height: 100,
                                width: 250,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  3,
                                  itemBuilder: (context, index) {
                                    return ReviewItem(reviewItem: null);
                                  },
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: const Text(
                              'Recommended for you',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 0),
                            height: 200,
                            child: SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  3,
                                  itemBuilder: (context, index) {
                                    return RecommendedItem(item: null);
                                  },
                                )),
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              }
            }));
  }

  Widget getDataImage(List<Gigdocument> item) {
    if (item.isNotEmpty) {
      print(item[0].fileName);
      return Image.network(
          "https://urbanmalta.com/public/users/user_${item[0].userid}/documents/${item[0].fileName}",
          height: double.infinity,
          width: 150,
          fit: BoxFit.fill);
    } else {
      return Image.asset('assets/images/barber.jpg',
          height: 120, width: 150, fit: BoxFit.fill);
    }
  }
}
