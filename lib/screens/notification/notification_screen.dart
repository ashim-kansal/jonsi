import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/notification.dart';
import 'package:kappu/models/serializable_model/NotificationModel.dart';
import 'package:kappu/net/http_client.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showNote = true;

  @override
  void initState() {
    super.initState();
    if(StorageManager().accessToken.isEmpty){

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
        children: [
          Text(
              "Notifications",
              style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(children: [
          showNote
              ? Container(
                  color: Color(0xFFF5F5F5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Account Notifications",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat-Bold',
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(18)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showNote = false;
                                        });
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Text(
                                  'Your general notifications are here. You can find all Your order notifications in the order tab.',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(13),
                                      color: Colors.white,
                                      fontFamily: 'Montserrat-Regular',
                                      height: 1.4),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' LAST 30 DAYS',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(13),
                              color: Color(0xFF7B7D83),
                              fontFamily: 'Montserrat-Regular',
                              height: 1.4),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          SizedBox(
              height: ScreenUtil().setHeight(590),
              child: FutureBuilder(
                  future: HttpClient()
                      .getNotifications(
                      StorageManager().userId.toString(),
                      "Bearer "+StorageManager().accessToken),
                  builder: (context,
                      AsyncSnapshot<List<NotificationModel>>
                          response) {
                    if (response.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: response.data!
                          .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color:  Color(0xFFE4E5EA),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              CircleAvatar(
                                radius: ScreenUtil().setHeight(30),
                                backgroundImage:
                                NetworkImage('https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(250),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title!,
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(14),
                                          color: Colors.black,
                                          fontFamily: 'Montserrat-Medium',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        DateFormat.jm().format(item.createdAt!).toString(),
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Color(0xFF7B7D83),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Montserrat-Regular',
                                            height: 1.4),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ))
                          .toList(),
                    );
                  })),
        ]),
      ),
    );
  }
}
