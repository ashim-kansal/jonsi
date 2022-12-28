import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/review.dart';

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
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(35),
                  left: ScreenUtil().setWidth(20)),
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
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(85)),
                    child: Text(
                      'Reviews',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Rating',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(18)),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade800,
                    ),
                    Text(
                      widget.averagerating.toString(),
                      style: TextStyle(
                          color: Colors.yellow.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: FutureBuilder(
                future: HttpClient().getproviderReviews(widget.providerid),
                builder: (context, AsyncSnapshot<List<Rating>> ratings) {
                  if (ratings.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(12),
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: ratings.data!
                        .map((item) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        item.ratingGiverprofileurl != null
                                            ? item.ratingGiverprofileurl!
                                            : 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(150),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10),
                                        ),
                                        child: Text(
                                          item.ratingGiverfname +
                                              " " +
                                              item.ratingGiverlname,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(13)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(80),
                                    ),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow.shade800,
                                              size: 14,
                                            ),
                                            Text(
                                              item.rating.toString(),
                                              style: TextStyle(
                                                  color: Colors.yellow.shade800,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(12)),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          item.ratingpublishedDate,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(10)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(55)),
                                  child: Text(
                                    item.ratingcomment,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Colors.grey,
                                        height: 1.4),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ))
                        .toList(),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
