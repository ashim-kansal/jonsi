import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../models/serializable_model/offer.dart';
import '../../../provider/provider_provider.dart';
import '../createoffer/create_offer.dart';
import '../offerdetail/offerdetail.dart';

class Myoffers extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  double totalprice = 0;
  List<String> options = ['Edit', 'Pause', 'Delete'];
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateOffer(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<ProviderProvider>(
          builder: (context, loggedinprovider, child) => FutureBuilder(
              future: HttpClient()
                  .getprovideroffer('Bearer ' + loggedinprovider.token),
              builder: (context, AsyncSnapshot<List<Offers>> myoffers) {
                if (myoffers.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(35),
                          left: ScreenUtil().setWidth(15)),
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
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Text(
                            "My Offers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(22)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView(
                          padding: EdgeInsets.zero,
                          children: myoffers.data!
                              .map(
                                (item) => Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(23),
                                      ScreenUtil().setHeight(10),
                                      ScreenUtil().setWidth(23),
                                      ScreenUtil().setHeight(10)),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: DottedBorder(
                                      color: item.ispaused
                                          ? Colors.redAccent
                                          : Colors.blue,
                                      borderType: BorderType.RRect,
                                      strokeWidth: 1,
                                      radius: const Radius.circular(20),
                                      child: Container(
                                          width: ScreenUtil().setWidth(310),
                                          decoration: BoxDecoration(
                                              color: item.ispaused
                                                  ? Colors.red.shade100
                                                  : Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.offertitle,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: ScreenUtil()
                                                              .setSp(13)),
                                                    ),
                                                    PopupMenuButton(
                                                      elevation: 3,
                                                      tooltip:
                                                          'Options for offer',
                                                      onSelected: (val) async {
//
//
//
//
//
//

                                                        if (val == 'Pause') {
                                                          Map<String, dynamic>
                                                              body = {
                                                            'is_paused': true
                                                          };
                                                          HttpClient()
                                                              .pauseorResumeservice(
                                                                item.offerid
                                                                    .toString(),
                                                                body,
                                                              )
                                                              .then((value) => {
                                                                    changedExternalState()
                                                                  })
                                                              .catchError((e) {
                                                            BaseDio.getDioError(
                                                                e);
                                                          });
                                                        } else if (val ==
                                                            'Resume') {
                                                          Map<String, dynamic>
                                                              body = {
                                                            'is_paused': false,
                                                          };
                                                          HttpClient()
                                                              .pauseorResumeservice(
                                                                item.offerid
                                                                    .toString(),
                                                                body,
                                                              )
                                                              .then((value) => {
                                                                    changedExternalState()
                                                                  })
                                                              .catchError((e) {
                                                            BaseDio.getDioError(
                                                                e);
                                                          });
                                                        }
//
//
//
//
//
//
//
                                                        else if (val ==
                                                            'Delete') {
                                                          HttpClient()
                                                              .deleteservice(
                                                                item.offerid
                                                                    .toString(),
                                                              )
                                                              .then((value) => {
                                                                    changedExternalState()
                                                                  })
                                                              .catchError((e) {
                                                            BaseDio.getDioError(
                                                                e);
                                                          });
                                                        }
                                                      },
                                                      itemBuilder: (_) => <
                                                          PopupMenuItem<
                                                              String>>[
                                                        const PopupMenuItem<
                                                                String>(
                                                            child: Text('Edit'),
                                                            value: 'Edit'),
                                                        PopupMenuItem<String>(
                                                            child: item.ispaused
                                                                ? const Text(
                                                                    'Resume')
                                                                : const Text(
                                                                    'Pause'),
                                                            value: item.ispaused
                                                                ? 'Resume'
                                                                : 'Pause'),
                                                        const PopupMenuItem<
                                                                String>(
                                                            child:
                                                                Text('Delete'),
                                                            value: 'Delete'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors
                                                          .yellow.shade800,
                                                    ),
                                                    Text(
                                                      item.averagerating
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .yellow.shade800,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    ),
                                                    Text(
                                                      '  (${item.reviewcount})',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(10),
                                                ),
                                                Text(
                                                  item.offerDescription,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 8, 8, 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      // showofferdetail(context);
                                                      pushDynamicScreen(context,
                                                          screen: OfferDetail(
                                                              offer: item));
                                                    },
                                                    child: const Text(
                                                        'View service Details'))
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    )
                  ],
                );
              }),
        ));
  }
}
