import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/booking.dart';

import '../../../common/customtexts.dart';
import '../../../models/serializable_model/offer.dart';
import '../../../net/http_client.dart';

class BookingOffer extends StatelessWidget {
  final Booking booking;
  const BookingOffer({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.verticalSpace,
        customtext(
          buttontext: 'This Booking is Related to offer',
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        10.verticalSpace,
        FutureBuilder(
            future: HttpClient().getservicebyid(booking.serviceid.toString()),
            builder: (context, AsyncSnapshot<Offers> offer) {
              if (offer.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return DottedBorder(
                color: Colors.blue,
                borderType: BorderType.RRect,
                strokeWidth: 1,
                radius: const Radius.circular(20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customtext(
                            buttontext: offer.data!.offertitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                              ),
                              customtext(
                                buttontext: ' 4.6  ',
                                color: Colors.yellow.shade800,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              customtext(
                                buttontext: '(21)',
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          customtext(
                            buttontext:
                                'Includes ${offer.data!.packages.length} Packages',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Text(offer.data!.offerDescription,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              )),
                          10.verticalSpace
                        ],
                      ),
                    )),
              );
            }),
      ],
    );
  }
}
