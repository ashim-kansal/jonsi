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
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: List.generate(response.data!.data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              pushDynamicScreen(context,
                                  screen: ProviderOffersFromHomePage(serviceid: response.data!.data[index].id, name: response.data!.data[index].name),
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
                                      response.data!.baseUrl+"/"+response.data!.data[index].image,
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
                                            fontFamily: 'Montserrat-Bold',)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              ],
            );
          })
        // Table(
        //   // border: TableBorder.all(color: Colors.black),
        //
        //   children: [
        //     TableRow(children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 9),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/electrician.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Electrician",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 7),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/mother.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Baby Sitter",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 10),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/bodypump.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Gym trainer",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 5),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/makeover.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Salon",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ]),
        //     TableRow(children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 1),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/doctor.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Doctor",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 8),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/household.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Cleaning",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 11),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/veterinary.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("Vet Doctor",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, left: 14.0, bottom: 12),
        //         child: GestureDetector(
        //           onTap: () {
        //             pushDynamicScreen(context,
        //                 screen: ProviderOffersFromHomePage(serviceid: 6),
        //                 withNavBar: false);
        //           },
        //           child: Container(
        //             height: ScreenUtil().setHeight(60),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0),
        //                   child: Image.asset(
        //                     'assets/images/application.png',
        //                     height: ScreenUtil().setHeight(30),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 4.0),
        //                   child: Text("More",
        //                       style: TextStyle(
        //                           color: Colors.grey,
        //                           fontSize: ScreenUtil().setSp(12),
        //                           fontWeight: FontWeight.w500)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ]),
        //   ],
        // ),

    );
  }
}
