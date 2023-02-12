import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/screens/ProviderScreens/order_review.dart';

import '../../common/button.dart';
import '../../common/validation_dialogbox.dart';
import '../../models/serializable_model/RecommendedServiceProvidersResponse.dart';
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
            builder: (context,
                AsyncSnapshot<List<RecommendedServiceProvidersResponse>>
                    response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: AppColors.app_bg,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 280,
                          color: Colors.grey,
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
                                    '',
                                    //response.data!=null?'${response.data![0].userData!.firstName!}' '${response.data![0].userData!.lastName!}':'',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                        ignoreGestures: true,
                                        itemPadding:
                                            EdgeInsets.only(right: 0.1),
                                        itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'I will provice you house cleaning service',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )),
                        Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      'India',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Member Joined',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      'Dec 2020',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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
                              children: [
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('Hourly Price',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))),
                                    Text('\$10',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
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
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().screenHeight *
                                                    0.035)),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Opacity(
                                          opacity: 0,
                                          child: Icon(Icons.arrow_forward_ios),
                                        ),
                                        Text(
                                          "Proceed",
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderReview(id: 1)));

                                     /* showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return WarningDialogBox(
                                              title: 'Delete Item',
                                              descriptions: 'Do you want to delete this job',
                                              buttonTitle:'Delete',
                                              buttonColor: AppColors.red,
                                              onPressed: (type) => {}, icon: Icons.cancel,
                                            );
                                          });*/
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
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                ignoreGestures: true,
                                itemPadding: EdgeInsets.only(right: 0.1),
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(left: 20, right: 20),
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
                                                fontWeight: FontWeight.bold))),
                                    Text('20 Reviews',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('5 Stars',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))),
                                    Text('20 Reviews',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                  value: 0.8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('5 Stars',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))),
                                    Text('20 Reviews',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('5 Stars',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))),
                                    Text('20 Reviews',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('5 Stars',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))),
                                    Text('20 Reviews',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 10),
                          child: const Text(
                            '125 Reviews',
                            style: TextStyle(
                                color: Color(0xffF79E1F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
                          height: 145,
                          child: SizedBox(
                              height: 100,
                              width: 250,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 250,
                                              child: Card(
                                                  child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: ScreenUtil()
                                                              .setHeight(15),
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              'Location',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating: 3,
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 20,
                                                          ignoreGestures: true,
                                                          itemPadding:
                                                              EdgeInsets.only(
                                                                  right: 0.1),
                                                          itemBuilder: (context,
                                                                  _) =>
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .amber),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(rating);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: const Text(
                            'Recommended for you',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 250,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                width: 120,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 120,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 120,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 120,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              );
            }));
  }
}
