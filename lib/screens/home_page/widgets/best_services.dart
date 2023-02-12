import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/service.dart';

class OurBestServices extends StatefulWidget {
  const OurBestServices({Key? key}) : super(key: key);

  @override
  _OurBestServicesState createState() => _OurBestServicesState();
}

class _OurBestServicesState extends State<OurBestServices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        children: tempserrvices
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Card(
                                    elevation: 2,
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(220),
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .stretch, // add this
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              child: Image.network(
                                                  item.imageUrl,
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
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        item.description,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(18),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
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
