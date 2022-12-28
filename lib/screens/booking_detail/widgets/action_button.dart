import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/flushbar.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/booking_action_button.dart';
import '../../../provider/userprovider.dart';
import '../../register/widgets/text_field.dart';
import 'complete_booking.dart';

class ActionButtons extends StatefulWidget {
  final String bookingstatus;
  final Booking booking;
  final Function setbookingstate;
  const ActionButtons(
      {Key? key,
      required this.booking,
      required this.setbookingstate,
      required this.bookingstatus})
      : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool acceptingrequest = false;
  bool rejectingrequest = false;
  bool accepted = false;
  bool cancelingrequest = false;
  bool cancelclicked = false;
  bool completeclicked = false;
  bool withdrwaingrequest = false;
  final TextEditingController _cancelreasoncontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.bookingstatus == "Active") {
      accepted = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) => Consumer<ProviderProvider>(
        builder: (context, provider, child) => Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !accepted ? 30.verticalSpace : 10.verticalSpace,
              if (user.token != '' && !accepted)
                CustomBookingButton(
                  color: Colors.grey,
                  onPressed: () async {
                    if (!withdrwaingrequest) {
                      withdrwaingrequest = true;
                      setState(() {});
                      Map<String, dynamic> body = {"is_rejected": true};
                      await HttpClient()
                          .acceptrejectbookingrequest(widget.booking.id, body)
                          .then((value) {
                        withdrwaingrequest = false;
                        accepted = true;
                        setState(() {});
                        showSuccessFlushBar(
                            context: context,
                            message: "Booking Request Withdrawn");
                        widget.setbookingstate();
                      }).catchError((e) {
                        withdrwaingrequest = false;
                        setState(() {});
                        showErrorFlushBar(context: context, message: e);
                      });
                    }
                  },
                  buttontext: 'Withdraw Request',
                  isLoading: withdrwaingrequest,
                ),
              if (user.token == '' && !accepted)
                CustomBookingButton(
                  color: Colors.blue,
                  buttontext: 'Accept Request',
                  isLoading: acceptingrequest,
                  onPressed: () async {
                    if (!acceptingrequest && !rejectingrequest) {
                      acceptingrequest = true;
                      setState(() {});
                      Map<String, dynamic> body = {"is_accepted": true};
                      await HttpClient()
                          .acceptrejectbookingrequest(widget.booking.id, body)
                          .then((value) {
                        acceptingrequest = false;
                        accepted = true;
                        setState(() {});
                        showSuccessFlushBar(
                            context: context,
                            message: "Booking Request Accepted");
                        widget.setbookingstate();
                      }).catchError((e) {
                        acceptingrequest = false;
                        setState(() {});
                        showErrorFlushBar(context: context, message: e);
                      });
                    }
                  },
                ),
              if (user.token == '' && !accepted)
                Column(
                  children: [
                    CustomBookingButton(
                      onPressed: () async {
                        if (!acceptingrequest && !rejectingrequest) {
                          rejectingrequest = true;
                          setState(() {});
                          Map<String, dynamic> body = {"is_rejected": true};
                          await HttpClient()
                              .acceptrejectbookingrequest(
                                  widget.booking.id, body)
                              .then((value) {
                            rejectingrequest = false;
                            accepted = true;
                            setState(() {});
                            showSuccessFlushBar(
                                context: context,
                                message: "Booking Request Rejected");
                            widget.setbookingstate();
                          }).catchError((e) {
                            rejectingrequest = false;
                            setState(() {});
                            showErrorFlushBar(context: context, message: e);
                          });
                        }
                      },
                      buttontext: 'Reject Request',
                      isLoading: rejectingrequest,
                      color: Colors.red,
                    ),
                  ],
                ),
              if (accepted)
                Column(
                  children: [
                    if (!cancelclicked && user.token != '')
                      Column(
                        children: [
                          10.verticalSpace,
                          CustomBookingButton(
                            onPressed: () {
                              completebottomsheet(context, widget.booking,
                                  widget.setbookingstate);
                            },
                            color: Colors.green,
                            buttontext: 'Mark Complete',
                            isLoading: cancelingrequest,
                          ),
                        ],
                      ),
                    if (cancelclicked)
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            10.verticalSpace,
                            CustomTextFormField(
                              maxlines: 4,
                              controller: _cancelreasoncontroller,
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Enter Cancellation Reason",
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter Cancellation Reason',
                            ),
                            CustomBookingButton(
                              onPressed: () {
                                setState(() {
                                  cancelclicked = false;
                                });
                              },
                              color: Colors.red,
                              buttontext: 'Cancel Cancellation Request',
                              isLoading: false,
                            ),
                            CustomBookingButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  if (!cancelingrequest) {
                                    cancelingrequest = true;
                                    setState(() {});
                                    Map<String, dynamic> body = {
                                      "is_cancelled": true,
                                      "cancelled_by": user.token != ''
                                          ? user.user.id
                                          : provider.provider.id,
                                      "comments": _cancelreasoncontroller.text
                                    };
                                    await HttpClient()
                                        .cancelactivebooking(
                                            widget.booking.id, body)
                                        .then((value) {
                                      cancelingrequest = false;

                                      setState(() {});
                                      showSuccessFlushBar(
                                          context: context,
                                          message: "Booking Cancelled");
                                      widget.setbookingstate();
                                    }).catchError((e) {
                                      cancelingrequest = false;
                                      setState(() {});
                                      showErrorFlushBar(
                                          context: context, message: e);
                                    });
                                  }
                                }
                              },
                              color: Colors.red,
                              buttontext: 'Confirm Cancellation',
                              isLoading: cancelingrequest,
                            ),
                          ],
                        ),
                      ),
                    if (!cancelclicked)
                      CustomBookingButton(
                        onPressed: () {
                          cancelclicked = true;
                          setState(() {});
                        },
                        color: Colors.red,
                        buttontext: 'Cancel',
                        isLoading: cancelingrequest,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
