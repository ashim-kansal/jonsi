import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/service_summary.dart';

class SearchScreen extends ModalRoute<void> {
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

  bool searching = false;
  TextEditingController searchController = TextEditingController();
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  top: ScreenUtil().setHeight(35)),
              child: CircleAvatar(
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
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(40),
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10)),
              child: Container(
                width: ScreenUtil().setWidth(280),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: searchController,
                  onFieldSubmitted: (value) => {if (value.length > 2) {}},
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(21),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      searching = true;
                      changedExternalState();
                    }
                  },
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6F6F6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6F6),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6F6),
                        )),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6F6F6),
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6F6F6),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    hintText: 'Search A Service',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(
                        "assets/images/Search.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        if (searching)
          SizedBox(
            height: ScreenUtil().setHeight(530),
            child: ListView(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: allservices
                  .map((item) => SizedBox(
                      height: ScreenUtil().setHeight(70),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // pushDynamicScreen(context,
                              //     screen: ProviderOffers(catagoryid: 1),
                              //     withNavBar: false);
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
                                        width: ScreenUtil().setWidth(60),
                                      )),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(200),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        bottom: ScreenUtil().setHeight(10)),
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
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            item.exta,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 25,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(40),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          )
                        ],
                      )))
                  .toList(),
            ),
          ),
      ]),
    );
  }
}
