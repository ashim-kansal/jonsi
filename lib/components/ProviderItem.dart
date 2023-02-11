import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/RecommendedServiceProvidersResponse.dart';

import '../screens/ProviderScreens/provider_detail.dart';

class ItemServicesCard extends StatefulWidget {
  RecommendedServiceProvidersResponse data;
  ItemServicesCard({required this.data});

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
    return GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  ProviderDetailScreen(id: widget.data.id!)));

        },
        child: Container(
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: Colors.white),
        child: Row(
          children: [
            Container(
              child: getImage(widget.data!),
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
                    this.widget.data.title!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColors.app_color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.values[4]),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      this.widget.data.description==null ? "" : this.widget.data.description!,
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
                        ' ${this.widget.data.rating} (0 Rating)',
                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Including 2 Packages',
                  //   textAlign: TextAlign.start,
                  //   style: TextStyle(color: Colors.black, fontSize: 10.sp),
                  // ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hourly Price  :  ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        Text(
                          this.widget.data.servicepackages?.price==null ? "\$0" : "\$${this.widget.data.servicepackages?.price}" ,
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
    ));
  }

  getImage(RecommendedServiceProvidersResponse item) {
    if(item.gigdocument!=null && item.gigdocument!.length>0 ){
      print(item.gigdocument![0].fileName);
      return Image.network("https://urbanmalta.com/public/users/user_${item.gigdocument![0].userid}/documents/${item.gigdocument![0].fileName}",
            height: 120,
            width: 150,
            fit: BoxFit.fill);
    }else{
      return Image.asset('assets/images/barber.jpg',
          height: 120,
          width: 150,
          fit: BoxFit.fill);
    }
  }
}
