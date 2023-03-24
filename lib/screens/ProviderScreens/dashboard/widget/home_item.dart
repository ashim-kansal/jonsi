import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../components/AppColors.dart';
class HomeItem extends StatelessWidget {
  /// Creates a widget combines of [InkWell], [Container], [Expanded].
  ///
  /// At least one of [label], [value], [onClick] must not be null.
  /// This widget used to set header for on boarding screens like [LoginScreen], [ForgotPasswordScreen], [LoginWithNumberScreen].
  ///
  /// This contains [title], [label] and [imagePath]{asset/} to show top header.
  HomeItem({
    Key ?key,
    required this.title,
    required this.imagePath,
    Function()? onTap,
  }): super(key: key);

  final String title;
  final String imagePath;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Card(
      elevation: 2,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Image.asset(imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover),

              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.text_desc,
                    fontSize: 12,
                    fontFamily: "Montserrat-Medium"
                ),
              )
            ],
          ),
        ),

        ),
    );
  }
}
