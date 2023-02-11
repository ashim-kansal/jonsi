import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/net/http_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../slider_offers.dart';

class Servicescontainer extends StatefulWidget {
  const Servicescontainer({Key? key}) : super(key: key);

  @override
  _ServicescontainerState createState() => _ServicescontainerState();
}

class _ServicescontainerState extends State<Servicescontainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: HttpClient().getCatagory(),
            builder: (context, AsyncSnapshot<CategoryResponse> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(response.data!.data.length, (index) {
                    return Card(
                        color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          pushDynamicScreen(context,
                              screen: ProviderOffersFromHomePage(
                                  serviceid: 6,
                                  name: response.data!.data[index].name,
                                  desc: response.data!.data[index].description),
                              withNavBar: false);
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.network(
                                  response.data!.baseUrl +
                                      "/" +
                                      response.data!.data[index].image,
                                  height: ScreenUtil().setHeight(30),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Center(
                                  child: Text(response.data!.data[index].name,
                                      style: TextStyle(
                                        color: AppColors.text_desc,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontFamily: 'Montserrat-Bold',
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }));
  }
}
