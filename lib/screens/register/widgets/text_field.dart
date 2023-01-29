// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextInputType keyboardType;
  bool showPassword;
  final Color? bordercolor;
  final int? maxlines;
  final bool? enabled;

  CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      required this.keyboardType,
      this.showPassword = false,
      this.bordercolor,
      this.maxlines = 1,
      this.enabled = true})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtil().screenHeight * 0.02),
        elevation: 5,
        child: TextFormField(
          enabled: widget.enabled,
          cursorColor: widget.bordercolor ?? Colors.black,
          maxLines: widget.maxlines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscuringCharacter: '*',
          readOnly: widget.readOnly!,
          obscureText: widget.showPassword,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
              child: widget.prefixIcon,
            ),
            prefixIconConstraints:
                BoxConstraints(maxHeight: ScreenUtil().setWidth(25)),
            suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: widget.suffixIcon,
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 25),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: widget.bordercolor,
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtil().setSp(14),
            ),
            errorStyle: TextStyle(
              color: Colors.red,
              wordSpacing: 5.0,

            ),
            labelStyle: TextStyle(
                color: Colors.green,

            ),
            contentPadding: EdgeInsets.only(left: 15, right: 3, top: 10, bottom: 10),
            // focusedBorder: OutlineInputBorder(
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     borderSide:
            //         BorderSide(color: widget.bordercolor ?? Colors.grey)),
            // enabledBorder: OutlineInputBorder(
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     borderSide:
            //         BorderSide(color: widget.bordercolor ?? Colors.grey)),
            // disabledBorder: OutlineInputBorder(
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     borderSide:
            //         BorderSide(color: widget.bordercolor ?? Colors.grey)),
            border: InputBorder.none,
          ),
          onChanged: widget.onChanged),)
    );
  }
}

class ElevatedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  bool showPassword;
  final Color? bordercolor;
  final int? maxlines;
  final bool? enabled;

  ElevatedTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      required this.keyboardType,
      this.showPassword = false,
      this.bordercolor,
      this.maxlines = 1,
      this.enabled = true})
      : super(key: key);

  @override
  _ElevatedTextFormFieldState createState() => _ElevatedTextFormFieldState();
}

class _ElevatedTextFormFieldState extends State<ElevatedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(ScreenUtil().screenHeight * 0.03),
      elevation: 20,
      child: TextFormField(
          enabled: widget.enabled,
          cursorColor: widget.bordercolor ?? Colors.black,
          maxLines: widget.maxlines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscuringCharacter: '*',
          obscureText: widget.showPassword,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 15),
                child: widget.prefixIcon,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: widget.suffixIcon,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(14),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              border: InputBorder.none),
          onChanged: widget.onChanged),
    );
  }
}
