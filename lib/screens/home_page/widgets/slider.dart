import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/TrendingServicesResponse.dart';
import 'package:kappu/net/http_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../ProviderScreens/provider_detail.dart';
import '../../slider_offers.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  Future<List<TrendingServicesResponse>>? _future;

  @override
  void initState() {
    _future = HttpClient().getTrendingCatagory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // height: ScreenUtil().setHeight(220),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        child: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot<List<TrendingServicesResponse>> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOutBack,
                    autoPlayInterval: const Duration(seconds: 3)),

                items: response.data!
                    .map((item) =>
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Stack(
                            children: [
                              Container(
                                  height: ScreenUtil().setHeight(170),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.4),
                                            BlendMode.darken),
                                        image: getImage(item)
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10),
                                  top: ScreenUtil().setHeight(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        item.slug,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(16),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(50),
                                    ),
                                    // Container(
                                    //   height: ScreenUtil().setHeight(28),
                                    //   width: ScreenUtil().setWidth(90),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       color: Colors.blue),
                                    //   child: Center(
                                    //     child: Text(
                                    //       'Book Now',
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: ScreenUtil().setSp(13)),
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(left: 25,right: 15,top: 5,bottom: 5),
                                      width: 160,
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(AppColors.app_color),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Book Now",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat-bold',
                                              ),
                                            ),
                                            SizedBox(width: 8,),
                                            Image.asset('assets/icons/arw.png', scale: 2,fit: BoxFit.cover),
                                          ],
                                        ),
                                        onPressed: ()  {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProviderDetailScreen(id: item.id!)));

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    )
                )
                    .toList(),
              );
            })

    );


  }

  getImage(TrendingServicesResponse item) {
    if(item.gigdocument!=null && item.gigdocument.length>0 ){
      return NetworkImage("https://urbanmalta.com/public/users/user_${item.gigdocument[0].userid}/documents/${item.gigdocument[0].fileName}");
    }else{
      return AssetImage(
        'assets/images/bycyclemechenic.jpg',
      );
    }
  }
}
