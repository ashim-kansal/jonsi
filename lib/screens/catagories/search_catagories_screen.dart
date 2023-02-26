import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/service_summary.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/provideroffers/provider_offers.dart';
import 'package:kappu/screens/slider_offers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../models/serializable_model/CategoryResponse.dart';
import '../home_page/widgets/search_text_field.dart';

class SearchCatagoriesScreen extends StatefulWidget {
  const SearchCatagoriesScreen({Key? key}) : super(key: key);

  @override
  _SearchCatagoriesScreenState createState() => _SearchCatagoriesScreenState();
}

class _SearchCatagoriesScreenState extends State<SearchCatagoriesScreen> {
  List<Category> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Column(
          children: [
            Text("Search services",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontFamily: "Montserrat-Bold")),
          ],
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(6)),
          child: SearchTextField(
            hintext: "Search Services",
            onSearchingComplete: (value) {
              data = data
                  .where(
                      (element) => element.name.contains(value))
                  .toList();
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        FutureBuilder(
            future: HttpClient().getCatagory(),
            builder: (context, AsyncSnapshot<CategoryResponse> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              data = response.data!.data;
              return Expanded(
                  child: ListView(
                    padding:
                    EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: data
                        .map((item) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pushDynamicScreen(context,
                                screen: ProviderOffersFromHomePage(
                                    serviceid: item.id,
                                    name: item.name,
                                    desc: item.description),
                                withNavBar: false);
                          },
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10),
                                    bottom:
                                    ScreenUtil().setHeight(8)),
                                child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.network(
                                      response.data!.baseUrl +
                                          "/" +
                                          item.image,
                                      width: 80,
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil()
                                              .setSp(16),
                                          fontFamily:
                                          "Montserrat-Bold"),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 8.0),
                                      child: Text(
                                        item.description,
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ScreenUtil()
                                                .setSp(14),
                                            fontFamily:
                                            "Montserrat-Regular"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    )
                                  ],
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
                  ));
            }),
      ],)
    );
  }

}

