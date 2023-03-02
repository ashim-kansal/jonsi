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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Container(
          width: double.infinity,
          color: Colors.white,
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
        FutureBuilder(
            future: HttpClient().getUserReviews(),
            builder: (context, AsyncSnapshot<List<Rating>> ratings) {
              if (ratings.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6)
                ),
                child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: ratings.data!.length,
                      itemBuilder: (context, index) {
                        return ReviewItem(reviewItem: null);
                      },
                    )),
              );
            })
      ]),
    );
  }
}
