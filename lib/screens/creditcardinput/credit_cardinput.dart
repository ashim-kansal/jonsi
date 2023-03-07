import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
// import '../enterbusinessdetail/business_detail_input.dart';
// import '../../localization/credit_cardinput.i18n.dart';

class CreditCardInput extends StatefulWidget {

  String? clientSecret = "";

  CreditCardInput({this.clientSecret});

  @override
  State<StatefulWidget> createState() {
    return CreditCardInputState();
  }
}

class CreditCardInputState extends State<CreditCardInput> {

  CardFieldInputDetails? _card;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(title: "Add New Card"),
      body: Container(
        color: AppColors.color_f2f7fd,
        padding: EdgeInsets.all(20),
        child: Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),

              children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.14),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                CardField(
                  onCardChanged: (card) {
                    setState(() {
                    _card = card!;
                    });
                  },
                ),
                    // Text("Enter Card Detail", style: TextStyle(color: Colors.black, fontFamily: 'Montserrat-Bold', fontSize: 16),),
                    // SizedBox(height: 10,),
                    // CustomTextFormField(
                    //   controller: _numberController,
                    //   hintText: 'Card Number',
                    //   keyboardType: TextInputType.number,
                    //   isValid: isValidNumber,
                    //   onChanged: (value) {
                    //     if (value.isNotEmpty) {
                    //       isValidNumber = true;
                    //     } else {
                    //       isValidNumber = false;
                    //     }
                    //     setState(() {});
                    //   },
                    //   validator: (value) => value!.isEmpty
                    //       ? "Enter Card Number"
                    //       : value!.length > 2
                    //       ? "Enter valid Card Number"
                    //       : null,
                    // ),
                    // SizedBox(height: 10,),
                    // Row(
                    //   children: [
                    //     Expanded(child: CustomTextFormField(
                    //       controller: _expController,
                    //       hintText: 'MM/YY',
                    //       keyboardType: TextInputType.number,
                    //       isValid: isValidEXP,
                    //       onChanged: (value) {
                    //         if (value.isNotEmpty) {
                    //           isValidEXP = true;
                    //         } else {
                    //           isValidEXP = false;
                    //         }
                    //         setState(() {});
                    //       },
                    //       validator: (value) => value!.isEmpty
                    //           ? "Enter Exp"
                    //           : value!.length != 4
                    //           ? "Enter valid EXP"
                    //           : null,
                    //     ),),
                    //     SizedBox(width: 10,),
                    //     Expanded(child: CustomTextFormField(
                    //       controller: _cvvController,
                    //       hintText: 'CVV',
                    //       keyboardType: TextInputType.number,
                    //       isValid: isValidCVV,
                    //       onChanged: (value) {
                    //         if (value.isNotEmpty) {
                    //           isValidCVV = true;
                    //         } else {
                    //           isValidCVV = false;
                    //         }
                    //         setState(() {});
                    //       },
                    //       validator: (value) => value!.isEmpty
                    //           ? "Enter Cvv"
                    //           : value!.length != 3
                    //           ? "Enter valid CVV"
                    //           : null,
                    //     ),)
                    //   ],
                    // ),
                    // SizedBox(height: 10,),
                    // CustomTextFormField(
                    //   controller: _numberController,
                    //   hintText: 'Name on Card',
                    //   keyboardType: TextInputType.text,
                    //   isValid: isValidName,
                    //   onChanged: (value) {
                    //     if (value.isNotEmpty) {
                    //       isValidName = true;
                    //     } else {
                    //       isValidName = false;
                    //     }
                    //     setState(() {});
                    //   },
                    //   validator: (value) => value!.isEmpty
                    //       ? "Enter Name"
                    //       : value!.length < 2
                    //       ? "Enter valid Name"
                    //       : null,
                    // ),

                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: ScreenUtil().screenHeight * 0.06,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.app_color),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().screenHeight * 0.03)),
                          ),
                        ),
                        child: Text(
                          "Pay Now",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat-Medium',
                          ),
                        ),
                        onPressed: () async {
                          if (_card != null && _card!.complete ?? false) {
                            CardDetails cd = CardDetails();
                            cd = cd.copyWith(number: _card?.number);
                            cd = cd.copyWith(expirationMonth: _card?.expiryMonth);
                            cd = cd.copyWith(expirationYear: _card?.expiryYear);
                            cd = cd.copyWith(cvc: _card?.cvc);
                            await Stripe.instance
                                .dangerouslyUpdateCardDetails(cd);
                            var preference = StorageManager();

                            try {

                              final billingDetails = BillingDetails(
                                email: preference.email,
                                phone: '',
                                address: Address(
                                  city: '',
                                  country: "",
                                  line1: '',
                                  line2: '',
                                  state: '',
                                  postalCode: '',
                                ),
                              ); // mocked data for tests

                              // 2. Create payment method
                              // final paymentMethod = await Stripe.instance.createPaymentMethod(
                              //     params: PaymentMethodParams.card(
                              //       paymentMethodData: PaymentMethodData(
                              //         billingDetails: billingDetails,
                              //       ),
                              //     ));

                              final paymentIntent = await Stripe.instance
                                  .handleNextAction(widget.clientSecret!);

                              if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
                                // 5. Call API to confirm intent
                                // await confirmIntent(paymentIntent.id);
                              // } else {
                                // Payment succedeed
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Error: {}')));
                              }
                            }catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Error: $e')));
                              rethrow;
                            }

                          }

                        }
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Spacer()
          ],
        )),
      ),
    );
  }

}



