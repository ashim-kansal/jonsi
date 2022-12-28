import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';

class ItemServicesCard extends StatefulWidget {
  // final CartItem item;
  // final VoidCallback onAddClick;
  // final VoidCallback onMinusClick;
  //
  // ItemCartCard({required this.item,required this.onAddClick,required this.onMinusClick});

  @override
  State<StatefulWidget> createState() {
    return ItemServicesCardState();
  }
}

class ItemServicesCardState extends State<ItemServicesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: Colors.white),
        child: Row(
          children: [
            Container(
              child: Image.asset('assets/images/barber.jpg',
                  height: 120,
                  width: 150,
                  fit: BoxFit.fill),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(topLeft: new Radius.circular(6), bottomLeft: new Radius.circular(6)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'John Carter',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColors.app_color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.values[4]),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      'I will provide you house cleaning services',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          color: AppColors.text_desc, fontSize: 10.sp),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: Colors.yellow,
                      ),
                      Text(
                        ' 4.0 (125 Rating)',
                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  Text(
                    'Including 2 Packages',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black, fontSize: 10.sp),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hourly Price',
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        Text(
                          '\$44',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
