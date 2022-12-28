import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/screens/booking_detail/widgets/order_summary.dart';

import '../../booking_detail/widgets/service_provider_or_user_summary.dart';

class CancelledBookingWidget extends StatefulWidget {
  final Booking booking;
  const CancelledBookingWidget({Key? key, required this.booking})
      : super(key: key);

  @override
  _CancelledBookingWidgetState createState() => _CancelledBookingWidgetState();
}

class _CancelledBookingWidgetState extends State<CancelledBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(330),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.red.shade50,
          border: Border.all(color: Colors.grey.shade400)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OrderSmmary(booking: widget.booking, bookingstatus: 'Cancelled'),
          ServiceProviderOrUserSummary(booking: widget.booking),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
            child: Text(
              'Reason For Cancelation',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Text(
              widget.booking.comments,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 13.sp),
            ),
          ),
        ]),
      ),
    );
  }
}
