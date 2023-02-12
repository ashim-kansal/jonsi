import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/constants/storage_manager.dart';

import '../../components/MyAppBar.dart';

class OrderReview extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;

  OrderReview({required this.bodyprovider});

  @override
  _OrderReviewState createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "Order review"),
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Divider(
                height: 0.5,
                color: Colors.grey,
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Image.asset('assets/images/barber.jpg',
                              height: 80, width: 80, fit: BoxFit.fill),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.bodyprovider['name'],
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.bodyprovider['desc'],
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Detail',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue.withOpacity(0.15),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.bodyprovider['name'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '\$' + widget.bodyprovider['price'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.withOpacity(0.15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '\$' + widget.bodyprovider['price'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Text(
                                      '\$' + widget.bodyprovider['price'],
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Text(
                                      '\$10',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                  ),
                  InkWell(
                      onTap: () {
                        placeOrder(StorageManager().accessToken,
                            StorageManager().userId, context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Add Payment Method',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ))
                ],
              ))
            ],
          ),
        ));
  }

  placeOrder(token, userId, context) {
    HttpClient()
        .addOrder(
            widget.bodyprovider['location'],
            'Bearer ' + token,
            double.parse(widget.bodyprovider['price']).round().toString(),
            widget.bodyprovider['provider_id'].toString(),
            widget.bodyprovider['service_id'].toString(),
            userId.toString(),
            widget.bodyprovider['location'],
            "USD",
            "3")
        .then((value) => {
          print(value),
      if (value.status) {
          showSuccessDialog(context, value.message)
    }
        })
        .catchError((e) {
      BaseDio.getDioError(e);
    });
  }

  showSuccessDialog(context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarningDialogBox(
            title: 'Success',
            descriptions: message,
            buttonTitle:'ok',
            buttonColor: AppColors.color_green,
            icon: Icons.cancel,
            onPressed: () {
              print('ok');
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        });
  }
}
