// import 'package:cool_datepicker/cool_datepicker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/flushbar.dart';
import 'package:kappu/models/serializable_model/offer.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ServicedateTime extends StatefulWidget {
  final Offers offer;
  final String address;
  const ServicedateTime({Key? key, required this.offer, required this.address})
      : super(key: key);

  @override
  _ServicedateTimeState createState() => _ServicedateTimeState();
}

class _ServicedateTimeState extends State<ServicedateTime> {
  String servicetime = '12:00';
  String servicedate = 'Select Date';
  TimeOfDay _time = TimeOfDay.now();
  bool requesting = false;
  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(45),
            left: ScreenUtil().setWidth(15),
          ),
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
        Image.asset(
          "assets/images/calenderclock.jpg",
          height: ScreenUtil().setHeight(300),
        ),
// calenderclock.jpg
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(25),
              bottom: ScreenUtil().setHeight(10)),
          child: Text(
            "Select Booking date",
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
          child: GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  theme: DatePickerTheme(
                      backgroundColor:
                          Theme.of(context).textTheme.bodyText1!.color!,
                      itemStyle:
                          TextStyle(color: Theme.of(context).backgroundColor)),
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 10)),
                  onChanged: (date) {}, onConfirm: (date) {
                setState(() {
                  // servicedate = date;
                  servicedate = date.toString().substring(0, 10);
                });
              }, currentTime: DateTime.now());
            },
            child: Container(
              height: ScreenUtil().setHeight(45),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  // errorText: validatePassword(emailcontroller.text),
                  border: InputBorder.none,

                  hintText: "  " + servicedate,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(20)),
                  // border: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                  // ),
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(25),
              bottom: ScreenUtil().setHeight(10),
              top: ScreenUtil().setHeight(10)),
          child: Text(
            "Select Booking Time",
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _time,

                  onChange: onTimeChanged,
                  minuteInterval: MinuteInterval.ONE,
                  // Optional onChange to receive value as DateTime
                  onChangeDateTime: (DateTime dateTime) {
                    servicetime = dateTime.toString().substring(11, 16);
                    setState(() {});
                  },
                ),
              );
            },
            child: Container(
              height: ScreenUtil().setHeight(45),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  // errorText: validatePassword(emailcontroller.text),
                  border: InputBorder.none,
                  suffixIcon: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 10, end: 20),
                    child: Icon(
                      Icons.watch,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: ScreenUtil().setHeight(20)),
                  suffixIconColor: Colors.blue,
                  hintText: "  " + servicetime,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(20)),
                  // border: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                  // ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        GestureDetector(
          onTap: () async {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 0.6,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 6,
                            width: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Confirmation',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          child: Text(
                            'You are booking a service\nat ${widget.address} for 21/3/2022 at 12:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20)),
                          child: StatefulBuilder(builder: (context, aa) {
                            return Column(
                              children: [
                                Consumer<UserProvider>(
                                  builder: (context, loggedinuser, child) =>
                                      GestureDetector(
                                    onTap: () async {
                                      requesting = true;
                                      aa(() {});
                                      List<Map<String, dynamic>>
                                          bookingpackagejson = [];
                                      for (var element
                                          in widget.offer.packages) {
                                        if (element.packageservicequantity >
                                            0) {
                                          bookingpackagejson.add({
                                            'package': element.packageid,
                                            'quantity':
                                                element.packageservicequantity,
                                          });
                                        }
                                      }
                                      print(bookingpackagejson);
                                      Map<String, dynamic> body = {
                                        'provider': widget.offer.userid,
                                        'user': loggedinuser.user.id,
                                        'service': widget.offer.offerid,
                                        'time': servicedate + " " + servicetime,
                                        'location': 'Office',
                                        'address': widget.address,
                                        'packages': bookingpackagejson
                                      };
                                      await HttpClient()
                                          .createbookingrequest(
                                              "Bearer " + loggedinuser.token,
                                              body)
                                          .then((value) {
                                        requesting = false;
                                        aa(() {});

                                        showSuccessFlushBar(
                                            context: context,
                                            message: "Booking Request Sent");
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                        print(value);
                                      }).catchError((e) {
                                        requesting = false;
                                        aa(() {});
                                        BaseDio.getDioError(e);
                                      });
                                    },
                                    child: Container(
                                      height: ScreenUtil().setHeight(40),
                                      width: ScreenUtil().setWidth(330),
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Center(
                                        child: requesting
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                'Confirm',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil().setWidth(16),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(10),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: ScreenUtil().setHeight(40),
                                    width: ScreenUtil().setWidth(330),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setWidth(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        )
                      ]),
                    ),
                  );
                });
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
            child: Container(
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(300),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: ScreenUtil().setWidth(16),
                  ),
                ),
              ),
            ),
          ),
        ),
        // ListView(shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        // children: items.map((e) => Container(

        // )).toList(),)
      ]),
    );
  }
}
