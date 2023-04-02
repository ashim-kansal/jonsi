import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/booking_detail/widgets/action_button.dart';
import 'package:kappu/screens/booking_detail/widgets/service_provider_or_user_summary.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../models/serializable_model/OrderListResponse.dart';
import '../../../net/base_dio.dart';
import '../../../net/http_client.dart';
import '../../add_review/add_review.dart';
import '../../booking_detail/request_booking_detail.dart';
import '../../booking_detail/widgets/order_summary.dart';
import '../../booking_detail/widgets/rating_widget.dart';

class BookingWidget extends StatefulWidget {
  final String bookingstatus;
  final Function(String) menuItemClicked;
  final OrderListResponse booking;

  const BookingWidget(
      {Key? key,
      required this.booking,
      required this.menuItemClicked,
      required this.bookingstatus})
      : super(key: key);

  @override
  _BookingWidgetState createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // pushDynamicScreen(context,
          //     screen: ServiceBookingDetail(
          //       bookingstatus: widget.bookingstatus,
          //       booking: widget.booking,
          //       setbookingstate: widget.setbookingstate,
          //     ),
          //     withNavBar: false);
        },
        child: Container(
        child: DecoratedBox(
        decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Container(
                    child: getImage(widget.booking),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10)),
                    ),
                  ),
                  10.horizontalSpace,
                  Container(
                    height: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.booking.serviceData!.title!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.values[4]),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            widget.booking.serviceData!.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                color: AppColors.text_desc, fontSize: 12.sp),
                          ),
                        ),
                        Text(
                          '\€${widget.booking.totalPrice}',
                          style: TextStyle(
                              color: AppColors.app_color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 6,),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: AppColors.divider,
              ),
                  SizedBox(height: 6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: ScreenUtil().setHeight(20),
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        this.widget.booking.userData!.firstName! +
                            " " +
                            this.widget.booking.userData!.lastName!,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat-Bold",
                            color: AppColors.text_desc),
                      ),
                    ],
                  ),
                  BookingLabel(widget.bookingstatus == "Active"
                      ? 0
                      : widget.bookingstatus == "Request"
                          ? 1
                          : widget.bookingstatus == "Completed"
                              ? 2
                              : 3)
                ],
              ),
                  SizedBox(height: 6,),

              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: AppColors.divider,
              ),
                  SizedBox(height: 6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getDate(this.widget.booking.createdAt!),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: "Montserrat-SemiBold"),
                  ),
                  if (widget.bookingstatus == 'Active' ||
                      widget.bookingstatus == 'Request')
                    PopupMenuButton(
                      icon: const Text("...", style: TextStyle(fontSize: 28, color: AppColors.app_black),),
                      itemBuilder: (context) {
                        return [
                          if (widget.bookingstatus == 'Request' &&
                              StorageManager().isProvider)
                            const PopupMenuItem(
                              value: 'accept',
                              child: Text(
                                'Request Accept',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.app_color),
                              ),
                            ),
                          const PopupMenuItem(
                            value: 'cancel',
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          if (widget.bookingstatus == 'Active' &&
                              !StorageManager().isProvider)
                            const PopupMenuItem(
                              value: 'complete',
                              child: Text(
                                'Complete',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )
                        ];
                      },
                      onSelected: widget.menuItemClicked,
                    )
                ],
              ),

              // 10.verticalSpace,
              // ServiceProviderOrUserSummary(booking: widget.booking),
              // widget.bookingstatus == "Completed" &&
              //     widget.booking.rating != 0
              //     ? BookingRatingWidget(booking: widget.booking)
              //     : Column(
              //   children: [
              //     10.verticalSpace,
              //     if (widget.bookingstatus == "Completed")
              //       Center(
              //         child: TextButton(
              //             onPressed: () {
              //               // pushDynamicScreen(context,
              //               //     screen: AddReview(
              //               //         setbookingstate:
              //               //         widget.setbookingstate,
              //               //         booking: widget.booking),
              //               //     withNavBar: false);
              //             },
              //             child: const Text("Add Feedback")),
              //       ),
              //   ],
              // ),
              // if (widget.bookingstatus != "Completed")
              // ActionButtons(
              //   booking: widget.booking,
              //   setbookingstate: widget.setbookingstate,
              //   bookingstatus: widget.bookingstatus,
              // ),
            ]),
          ),)
        ));
  }

  String getDate(dateTime) => DateFormat('dd MMM yyyy').format(dateTime);
}

BookingLabel(int i) {
  if(i==3){
    return const SizedBox();
  }
  return SizedBox(
    height: 40,
    width: 100,
    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(i == 0
            ? const Color(0x4995EB40)
            : i == 1
                ? const Color(0x70707040)
                : i == 2
                    ? const Color(0x34A85340)
                    : const Color(0xFF000040)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      child: Text(
        i == 0
            ? "Active"
            : i == 1
                ? "Request"
                : i == 2
                    ? "Completed"
                    : "Cancel",
        style: TextStyle(
          color: i == 0
              ? AppColors.app_color
              : i == 1
                  ? AppColors.color_707070
                  : i == 2
                      ? AppColors.color_green
                      : Color(0xFFFF0000),
          fontSize: 14,
          fontFamily: 'Montserrat-SemiBold',
        ),
      ),
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProviderDetailScreen(id: item.id!)));
      },
    ),
  );
}

getImage(OrderListResponse item) {
  if (item.gigdocument != null && item.gigdocument!.length > 0) {
    return Image.network(
        "https://urbanmalta.com/public/users/user_${item.gigdocument![0].userid}/documents/${item.gigdocument![0].fileName}",
        height: 80,
        width: 100,
        fit: BoxFit.fill);
  } else {
    return Image.asset('assets/images/barber.jpg',
        height: 80, width: 100, fit: BoxFit.fill);
  }
}
