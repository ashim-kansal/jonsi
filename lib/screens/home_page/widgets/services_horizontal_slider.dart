import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/serializable_model/offer.dart';
import '../../../net/http_client.dart';

class ServicesSliderHorizontal extends StatefulWidget {
  const ServicesSliderHorizontal({Key? key}) : super(key: key);

  @override
  _ServicesSliderHorizontalState createState() =>
      _ServicesSliderHorizontalState();
}

class _ServicesSliderHorizontalState extends State<ServicesSliderHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      child: Text(
                        'Home & Car Cleaning',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(21)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'See all',
                        style: TextStyle(
                            //   ,

                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              children: [
                SizedBox(
                  height: 245.h,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
                    child: FutureBuilder(
                        future: HttpClient().getoffersbycatagory(6),
                        builder:
                            (context, AsyncSnapshot<List<Offers>> snapshot) {
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              children: snapshot.data!
                                  .map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            width: ScreenUtil().setWidth(220),
                                            child: InkWell(
                                              onTap: () => {},
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .stretch, // add this
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8)),
                                                    child: Image.asset(
                                                        'assets/images/barber.jpg',
                                                        // width: 300,
                                                        height: ScreenUtil()
                                                            .setHeight(125),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  ListTile(
                                                      title: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              item.offertitle,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Radomir Tinkov',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              14),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          10.verticalSpace,
                                                          Text(
                                                            item.userfirstname +
                                                                " " +
                                                                item.userlastname,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Radomir Tinkov',
                                                                color:
                                                                    Colors.grey,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800,
                                                              ),
                                                              Text(
                                                                item.reviewcount ==
                                                                        0
                                                                    ? ' Not rated yet'
                                                                    : item
                                                                        .averagerating
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Radomir Tinkov',
                                                                    color: Colors
                                                                        .yellow
                                                                        .shade800,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                              if (item.reviewcount !=
                                                                  0)
                                                                Text(
                                                                  ' (${item.reviewcount.toString()}) Ratings',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Radomir Tinkov',
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.sp),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList());
                        }),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
