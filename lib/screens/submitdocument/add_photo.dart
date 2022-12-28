import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AddPhotoWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool isImage;

  final String? url;
  final bool isUploading;
  final double? progress;
  final IconData? icon;
  final VoidCallback? onTapCancel;
  const AddPhotoWidget({
    required this.onTap,
    required this.isImage,
    this.url,
    required this.isUploading,
    this.progress,
    this.icon,
    this.onTapCancel,
  });

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? thumb;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2.5,
              blurRadius: 3.0,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: !widget.isImage
            ? !widget.isUploading
                ? Icon(
                    widget.icon ?? Icons.add_photo_alternate_outlined,
                    color: Colors.grey,
                    size: 40,
                  )
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircularPercentIndicator(
                          radius: 30.0,
                          lineWidth: 3.0,
                          percent: widget.progress!,
                          progressColor: Colors.blue,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: widget.onTapCancel ?? () {},
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
            : Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.url!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
