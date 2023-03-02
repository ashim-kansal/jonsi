import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/net/http_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/serializable_model/PopularServiceListResponse.dart';
import '../../slider_offers.dart';

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
          child: Column(
            children: [
              SizedBox(
                height: 130,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                    child: FutureBuilder(
                        future: HttpClient().getPopularServices(),
                        builder: (context,
                            AsyncSnapshot<List<PopularServiceListResponse>>
                                response) {
                          if (response.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              children: response.data!
                                  .map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          child: SizedBox(
                                            width: 110,
                                            height: 100,
                                            child: InkWell(
                                              onTap: () => {
                                                pushDynamicScreen(context,
                                                    screen: ProviderOffersFromHomePage(
                                                        serviceid: item.id!,
                                                        name: item.name!,
                                                        desc: "item.description"),
                                                    withNavBar: false)
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .stretch,
                                                mainAxisAlignment: MainAxisAlignment.center, // add this
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    child:
                                                        getImage(item.image!),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(12),
                                                    child: Text(
                                                      item.name!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .text_desc,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                          fontFamily: "Montserrat-bold",),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList());
                        })),
              ),
            ],
          ),
        )
      ],
    );
  }

  getImage(String image) {
    return Image.network(
        "https://urbanmalta.com/public/uploads/servicecategory/$image",
        height: 60,
        width: 110,
        fit: BoxFit.fill);
  }
}
