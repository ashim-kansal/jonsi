import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/bookings/widgets/cancelled_booking.dart';
import 'package:kappu/screens/bookings/widgets/booking_widget.dart';
import 'package:provider/provider.dart';

import '../../models/serializable_model/OrderListResponse.dart';
import '../../net/base_dio.dart';
import '../login/login_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  reloadpage() {
    setState(() {});
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (StorageManager().accessToken.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(isFromOtherScreen: true)));
        if (result == "1") {
          reloadpage();
        }
      });
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(100)),
          child: AppBar(
            bottom: TabBar(
              indicatorWeight: 4,
              indicatorColor: AppColors.app_color,
              labelColor: AppColors.app_color,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              labelStyle: TextStyle(fontFamily: "Montserrat-Bold", fontSize: 14, color: Colors.black),
              tabs: [
                Tab(
                  text: 'Active',
                ),
                Tab(text: "Requests"),
                Tab(
                  text: "Completed",
                ),
                Tab(
                  text: "Cancelled",
                ),
              ],
            ),
            title: Stack(
              children: [
                Column(
                  children: [
                    Text("Manage Order",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontFamily: "Montserrat-Bold")),
                  ],
                ),
                if (isLoading)
                  const SizedBox()
              ],
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            elevation: 2,
          ),
        ),
        body: Consumer<UserProvider>(
          builder: (context, loggedinuser, child) => Consumer<ProviderProvider>(
            builder: (context, loggedinprovider, child) {
              return TabBarView(children: [
                FutureBuilder(
                    future: HttpClient().getActivebookings(
                        StorageManager().userId.toString(),
                        "Bearer " + StorageManager().accessToken,
                        StorageManager().isProvider ? "provider" : "user"),
                    builder: (context,
                        AsyncSnapshot<List<OrderListResponse>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              const Text("No Active Bookings ", style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Regular")),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Reload')),
                            ],
                          ),
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.only(bottom: 50),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((item) => Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: BookingWidget(
                                    bookingstatus: 'Active',
                                    booking: item,
                                    menuItemClicked: (String value) {
                                      callAPI(value, item.id.toString());
                                    },
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getrequestedbookings(
                        StorageManager().userId.toString(),
                        "Bearer " + StorageManager().accessToken,
                        StorageManager().isProvider ? "provider" : "user"),
                    builder: (context,
                        AsyncSnapshot<List<OrderListResponse>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 250.h),
                          child: Column(
                            children: [
                              const Text("No Requests for Bookings "),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Reload'))
                            ],
                          ),
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.only(bottom: 50),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((item) => Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: BookingWidget(
                                    bookingstatus: 'Request',
                                    booking: item,
                                    menuItemClicked: (String value) {
                                      callAPI(value, item.id.toString());
                                    },
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getcompletedbooking(
                        StorageManager().userId.toString(),
                        "Bearer " + StorageManager().accessToken,
                        StorageManager().isProvider ? "provider" : "user"),
                    builder: (context,
                        AsyncSnapshot<List<OrderListResponse>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 250.h),
                          child: Column(
                            children: [
                              const Text("No Completed Bookings "),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Reload'))
                            ],
                          ),
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.only(bottom: 50),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((item) => Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: BookingWidget(
                                    bookingstatus: "Completed",
                                    booking: item,
                                    menuItemClicked: (String value) {
                                      callAPI(value, item.id.toString());
                                    },
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getCancelledbooking(
                        StorageManager().userId.toString(),
                        "Bearer " + StorageManager().accessToken,
                        StorageManager().isProvider ? "provider" : "user"),
                    builder: (context,
                        AsyncSnapshot<List<OrderListResponse>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 250.h),
                          child: Column(
                            children: [
                              const Text("No Cancelled Bookings "),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Reload'))
                            ],
                          ),
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.only(bottom: 50),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((item) => Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: BookingWidget(
                                    bookingstatus: "Cancel",
                                    booking: item,
                                    menuItemClicked: (String value) {
                                      callAPI(value, item.id.toString());
                                    },
                                  ),
                                ))
                            .toList(),
                      );
                    }),
              ]);
            },
          ),
        ),
      ),
    );
  }

  Future<void> callAPI(String value, String bookingId) async {
    setState(() {
      isLoading = true;
    });
    if (value == 'complete') {
      await HttpClient()
          .completeOrder(bookingId.toString(), "Bearer "+StorageManager().accessToken)
          .then((value) {
        if (value.status) {
          setState(() {
            isLoading = false;
          });
          reloadpage();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    } else if (value == 'accept') {
      await HttpClient()
          .acceptOrder(bookingId.toString(), "Bearer "+StorageManager().accessToken)
          .then((value) {
        if (value.status) {
          setState(() {
            isLoading = false;
          });
          reloadpage();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    } else if (value == 'cancel') {
      await HttpClient()
          .cancelOrder(bookingId.toString(), "Bearer "+StorageManager().accessToken)
          .then((value) {
        if (value.status) {
          setState(() {
            isLoading = false;
          });
          reloadpage();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }
}
