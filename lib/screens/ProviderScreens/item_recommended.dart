import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/provider_detail_model.dart';

class RecommendedItem extends StatelessWidget {
  const RecommendedItem({Key? key, required this.item}) : super(key: key);
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage('assets/images/barber.jpg'))),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: const Text(
              'John carter',
              style: TextStyle(
                  color: AppColors.app_color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: const Text(
              'I will provice you house cleaning service',
              maxLines: 3,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                    child: Text('Hourly Price',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight:
                            FontWeight.bold))),
                Text(
                    '\$ 10',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
