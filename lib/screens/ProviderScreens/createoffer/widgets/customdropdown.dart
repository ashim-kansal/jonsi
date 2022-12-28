import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customDropDown(
    {required BuildContext context,
    required void Function(dynamic) onChanged,
    required List<DropdownMenuItem<dynamic>> items,
    required dynamic value,
    required String hint}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.067,
    child: Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DropdownButtonHideUnderline(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
              hint: Text(hint, style: TextStyle(fontSize: ScreenUtil().setSp(18))),
              isExpanded: true,
              itemHeight: 50,
              style: TextStyle(color: Colors.green, fontSize: ScreenUtil().setSp(18)),
              items: items,
              onChanged: onChanged,
              value: value),
        )),
      ),
    ),
  );
}
