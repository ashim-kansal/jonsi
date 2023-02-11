import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/service_summary.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/provideroffers/provider_offers.dart';
import 'package:kappu/screens/slider_offers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../models/serializable_model/CategoryResponse.dart';

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({Key? key}) : super(key: key);

  @override
  _CatagoriesScreenState createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Catagoies"),
      body: FutureBuilder(
          future: HttpClient().getCatagory(),
          builder: (context, AsyncSnapshot<CategoryResponse> response) {
            if (response.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: response.data!.data
                  .map((item) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pushDynamicScreen(context,
                          screen: ProviderOffersFromHomePage(serviceid: item.id, name: item.name, desc: item.description),
                          withNavBar: false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(10),
                              bottom: ScreenUtil().setHeight(8)),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                              child: Image.network(
                                response.data!.baseUrl+"/"+item.image,
                                width: ScreenUtil().setWidth(100),
                              )),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(200),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(40),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  )
                ],
              ))
                  .toList(),
            );
          }),

    );
  }
}
