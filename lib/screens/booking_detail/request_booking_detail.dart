// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kappu/common/customtexts.dart';
// import 'package:kappu/models/serializable_model/booking.dart';
// import 'package:kappu/provider/userprovider.dart';
// import 'package:kappu/screens/booking_detail/widgets/action_button.dart';
// import 'package:kappu/screens/booking_detail/widgets/booking_offer_widget.dart';
// import 'package:kappu/screens/booking_detail/widgets/order_price_summary.dart';
// import 'package:kappu/screens/booking_detail/widgets/order_summary.dart';
// import 'package:kappu/screens/booking_detail/widgets/rating_widget.dart';
// import 'package:kappu/screens/booking_detail/widgets/service_provider_or_user_summary.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';
//
// import '../add_review/add_review.dart';
//
// class ServiceBookingDetail extends ModalRoute<void> {
//   final String bookingstatus;
//   final Booking booking;
//   final Function setbookingstate;
//
//   ServiceBookingDetail({
//     required this.booking,
//     required this.setbookingstate,
//     required this.bookingstatus,
//   });
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 500);
//
//   @override
//   bool get opaque => false;
//
//   @override
//   bool get barrierDismissible => false;
//
//   @override
//   Color get barrierColor => Colors.black.withOpacity(0.5);
//
//   @override
//   String get barrierLabel => "";
//
//   @override
//   bool get maintainState => true;
//
//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     // This makes sure that text and other content follows the material style
//     return Material(
//       type: MaterialType.transparency,
//       child: _buildOverlayContent(context),
//     );
//   }
//
//   double totalprice = 0;
//   Widget _buildOverlayContent(BuildContext context) {
//     return Scaffold(
//       body: Column(children: [
//         Container(
//           height: 90.h,
//           color: Colors.blue,
//           child: Padding(
//             padding: EdgeInsets.only(left: 15.w, top: 30.h),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.arrow_back),
//                     ),
//                   ),
//                   customtext(
//                     buttontext: booking.id.toString() + "12AS234",
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   90.horizontalSpace,
//                   Padding(
//                     padding: EdgeInsets.only(right: 20.w),
//                     child: CircleAvatar(
//                         radius: 22,
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.message,
//                               size: 24,
//                             ))),
//                   ),
//                 ]),
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Consumer<UserProvider>(
//               builder: (context, user, child) => Padding(
//                 padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       OrderSmmary(
//                           booking: booking, bookingstatus: bookingstatus),
//                       ServiceProviderOrUserSummary(booking: booking),
//                       bookingstatus == "Completed" && booking.rating != 0
//                           ? BookingRatingWidget(booking: booking)
//                           : Column(
//                               children: [
//                                 10.verticalSpace,
//                                 if (user.token != '' &&
//                                     bookingstatus == "Completed")
//                                   const Divider(thickness: 1),
//                                 if (user.token != '' &&
//                                     bookingstatus == "Completed")
//                                   Center(
//                                     child: TextButton(
//                                         onPressed: () {
//                                           pushDynamicScreen(context,
//                                               screen: AddReview(
//                                                   setbookingstate:
//                                                       setbookingstate,
//                                                   booking: booking),
//                                               withNavBar: false);
//                                         },
//                                         child: const Text("Add Feedback")),
//                                   ),
//                               ],
//                             ),
//                       if (bookingstatus != "Completed")
//                         BookingOffer(booking: booking),
//                       20.verticalSpace,
//                       customtext(
//                         buttontext: 'Order Summary',
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                       10.verticalSpace,
//                       OrderPriceSummary(
//                         booking: booking,
//                       ),
//                       if (bookingstatus != "Completed")
//                         ActionButtons(
//                           bookingstatus: bookingstatus,
//                           setbookingstate: setbookingstate,
//                           booking: booking,
//                         ),
//                       20.verticalSpace,
//                     ]),
//               ),
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }
