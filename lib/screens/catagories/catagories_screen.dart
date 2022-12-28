import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/service_summary.dart';
import 'package:kappu/screens/provideroffers/provider_offers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: ScreenUtil().setHeight(570),
            child: ListView(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: allservices
                  .map((item) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushDynamicScreen(context,
                                  screen: ProviderOffers(service: item),
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
                                      child: Image.asset(
                                        item.imagepath,
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
                                          item.servicename,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            item.exta,
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
            ),
          ),
        ]),
      ),
    );
  }
}
