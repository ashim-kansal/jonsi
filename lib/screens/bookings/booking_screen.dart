import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/bookings/widgets/cancelled_booking.dart';
import 'package:kappu/screens/bookings/widgets/booking_widget.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  reloadpage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(100)),
          child: AppBar(
            bottom: TabBar(
              indicatorWeight: 4,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
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
            title: Column(
              children: [
                Text("Manage Order",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.all(10),
              child: RawMaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                fillColor: AppColors.app_color,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.0,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
              ),
            ),
            shadowColor: Colors.white,
            elevation: 2,
          ),
        ),
        body: Consumer<UserProvider>(
          builder: (context, loggedinuser, child) => Consumer<ProviderProvider>(
            builder: (context, loggedinprovider, child) {
              return TabBarView(children: [
                FutureBuilder(
                    future: HttpClient().getactivebookingrequest(
                        false,
                        true,
                        false,
                        "Bearer " ),
                    builder: (context, AsyncSnapshot<List<Booking>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data== null || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              const Text("No Active Bookings "),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Reload')),
                              Padding(
                                padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: BookingWidget(
                                  bookingstatus: 'Completed',
                                  setbookingstate: reloadpage,
                                  booking: getBooking(),
                                ),
                              ),
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
                                    setbookingstate: reloadpage,
                                    booking: item,
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getrequestedbooking(
                        false,
                        false,
                        "Bearer " ),
                    builder: (context, AsyncSnapshot<List<Booking>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data== null || snapshot.data!.isEmpty) {
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
                                    bookingstatus: 'Requested',
                                    setbookingstate: reloadpage,
                                    booking: item,
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getcompletedbooking(
                        true,
                        "Bearer " ),
                    builder: (context, AsyncSnapshot<List<Booking>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data== null || snapshot.data!.isEmpty) {
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
                                    setbookingstate: reloadpage,
                                    booking: item,
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                FutureBuilder(
                    future: HttpClient().getcancelledbooking(
                        true,
                        "Bearer " ),
                    builder: (context, AsyncSnapshot<List<Booking>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data== null || snapshot.data!.isEmpty) {
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
                                  child: CancelledBookingWidget(
                                    booking: item,
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

  Booking getBooking() {
    return Booking(
        id: 1,
        userfname: "userfname",
        userlname: "userlname",
        useremail: "useremail",
        userid: 11,
        providerid: 12,
        providerfname: "providerfname",
        providerlname: "providerlname",
        provideremail: "provideremail",
        location: "location",
        address: "address",
        time: "time",
        totalprice: 100.11,
        serviceid: 13,
        servicetitle: "servicetitle",
        boughtpackages: [],
        comments: "comments",
        rating: 0);
  }
}
