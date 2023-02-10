
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';

class ExpandableQuestionWidget extends StatefulWidget {

  final String? answer;
  final String? question;

  const ExpandableQuestionWidget({Key? key, this.answer, this.question}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ExpandableQuestionWidgetState();
  }

}

class ExpandableQuestionWidgetState extends State<ExpandableQuestionWidget> {
  bool showanser = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        color: showanser ? Color(0xffD8ECFF) : Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                // Container(width: 5, height: 30, color: Colors.black),
                10.horizontalSpace,
                Text(
                  widget.question!,
                  style: TextStyle(
                      color: AppColors.text_desc,
                      fontFamily: "Montserrat-Regular",
                      fontSize: 12),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showanser = !showanser;
                      });
                    },
                    icon: Icon(
                      showanser
                          ? Icons.close
                          : Icons.add,
                      size: 20,
                      color: showanser ? AppColors.app_color : AppColors.text_desc,
                    )),
              ],
            ),
            if (showanser)
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                widget.answer!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: AppColors.text_desc,
                    fontFamily: "Montserrat-Regular",
                    fontSize: 12),
              ),)
          ],
        ),
      ),
    );
  }

}