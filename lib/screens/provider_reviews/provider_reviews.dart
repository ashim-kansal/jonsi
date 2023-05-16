import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/models/serializable_model/review.dart';
import 'package:kappu/screens/ProviderScreens/item_review.dart';

import '../../net/http_client.dart';

class ProviderReviewsPage extends StatefulWidget {
  final int providerid;
  final double averagerating;

  const ProviderReviewsPage(
      {Key? key, required this.providerid, required this.averagerating})
      : super(key: key);

  @override
  _ProviderReviewsPageState createState() => _ProviderReviewsPageState();
}

class _ProviderReviewsPageState extends State<ProviderReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(
        title: "Total Ratings and Reviews",
      ),
      body: ListView(shrinkWrap: true, children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Reviews as Seller",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: "Montserrat-Bold"),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: EdgeInsets.only(right: 2),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text('3')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  color: AppColors.shadow,
                ),
                SizedBox(
                  height: 10,
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
                                        fontFamily: 'Montserrat-Bold'))),
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
                              AppColors.app_color),
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
                                        fontFamily: 'Montserrat-Bold'))),
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
                              AppColors.app_color),
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
                                        fontFamily: 'Montserrat-Bold'))),
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
                              AppColors.app_color),
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
                                        fontFamily: 'Montserrat-Bold'))),
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
                              AppColors.app_color),
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
                                        fontFamily: 'Montserrat-Bold'))),
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
                              AppColors.app_color),
                          value: 20,
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: FutureBuilder(
                future: HttpClient().getUserReviews(),
                builder: (context, AsyncSnapshot<List<Rating>> ratings) {
                  if (ratings.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(12),
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: ScreenUtil().setHeight(15),
                              backgroundImage: NetworkImage(
                                  'https://urbanmalta.com/public/frontend/images/johnwing.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Location',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                                    ),
                                    Text(
                                      ' 5.0',
                                      style: TextStyle(
                                          color: AppColors.app_yellow,
                                          fontFamily: "Montserrat-Bold",
                                          fontSize: 10),
                                    ),
                                    Text(
                                      '  5 days ago',
                                      style: TextStyle(
                                          color: AppColors.text_desc,
                                          fontFamily: "Montserrat-Medium",
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        )
      ]),
    );
  }
}
