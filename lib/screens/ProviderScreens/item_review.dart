import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/provider_detail_model.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem(
      {Key ?key,
        required this.reviewItem})
      : super(key: key);
  final dynamic reviewItem;

  @override
  Widget build(BuildContext context) {
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
                        CrossAxisAlignment
                            .start,
                        mainAxisAlignment:
                        MainAxisAlignment
                            .start,
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
                                radius:
                                ScreenUtil()
                                    .setHeight(
                                    15),
                                backgroundImage:
                                NetworkImage(
                                    'https://urbanmalta.com/public/frontend/images/johnwing.png'),
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
                                        fontSize:
                                        15,
                                        fontWeight:
                                        FontWeight
                                            .bold),
                                  ),
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        15,
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
                                direction: Axis
                                    .horizontal,
                                allowHalfRating:
                                true,
                                itemCount: 5,
                                itemSize: 20,
                                ignoreGestures:
                                true,
                                itemPadding:
                                EdgeInsets.only(
                                    right:
                                    0.1),
                                itemBuilder: (context,
                                    _) =>
                                    Icon(
                                        Icons
                                            .star,
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
                            'Lorem ispum Lorem ispum Lorem ispum Lorem ispum Lorem ispum',
                            maxLines: 3,
                            style: TextStyle(
                                color:
                                Colors.grey,
                                fontSize: 12,
                                fontWeight:
                                FontWeight
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
  }
}
