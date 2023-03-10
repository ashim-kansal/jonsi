import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/ProviderItem.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/AddOrderResponse.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/creditcardinput/credit_cardinput.dart';

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
    // initPaymentSheet();
  }



  Future<void> initPaymentSheet(AddOrderResponse data) async {

    try {
      print(data.stripeintent!.toJson().toString());
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          customFlow: true,
          // setupIntentClientSecret: 'sk_test_51Lde8bIv5chsib1PT1sD0GFaWv5viIQzU6zIwIqzOK9ULVWiQChmZ1huNaLibaIUJNszVnpG5Dk64wF0XR08wMnx00x2YIx8vp',
          // Main params
          merchantDisplayName: 'UrbanMalta',
          paymentIntentClientSecret: data.stripeintent!.clientSecret,
          primaryButtonLabel: 'Pay now',
          applePay: Platform.isIOS?PaymentSheetApplePay(
            merchantCountryCode: 'MT',
          ):null,
          googlePay: Platform.isAndroid? PaymentSheetGooglePay(
            merchantCountryCode: 'MT',
            testEnv: true,
          ) : null,
          style: ThemeMode.dark,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.white,
              primary: Colors.blue,
            ),
            shapes: PaymentSheetShape(
              borderWidth: 4,
              shadow: PaymentSheetShadowParams(color: AppColors.color_707070),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColors.app_color,
                  text: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ).then((value) {
        showPaymentSheet(data.orderData!.id);
      });

      //
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             CreditCardInput(clientSecret: data.stripeintent!.clientSecret,)));

      //     setState(() {
      //   _ready = true;
      // });
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
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
                    child: getCard(Padding(
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
                    child: getCard(Padding(
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
                                  color: AppColors.app_color,
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
                                  '\€' + widget.bodyprovider['price'],
                                  style: TextStyle(
                                      color: AppColors.app_color,
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
                    child: getCard(Padding(
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
                                      '\€' + widget.bodyprovider['price'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Text(
                                      '\€' + widget.bodyprovider['price'],
                                      style: TextStyle(
                                          color: AppColors.app_color,
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
                                      '\€10',
                                      style: TextStyle(
                                          color: AppColors.app_color,
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
                    )
                    ),
                  ),
                  InkWell(
                      onTap: () async{

                        placeOrder(StorageManager().accessToken,
                            StorageManager().userId, context);

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.app_color,
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
            "EUR",
            "0").then((value) => {
              print(value),
                if (value.status!) {
                    // showSuccessDialog(context, value.message)
                  initPaymentSheet(value)
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

  void showPaymentSheet(orderId) async{
    await Stripe.instance.presentPaymentSheet().then((value){
      HttpClient().orderPayment(orderId).then((value){}).onError((error, stackTrace) {});
    }).onError((error, stacktrace) {
      print("Error is $error $stacktrace");
    });

  }
}


  _createTestPaymentSheet() async{

  }