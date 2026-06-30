import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';

void showInfoDialog(BuildContext context, content,
    {int height = 300, int width = 100}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: containerColor,
          //insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            height: height.h,
            width: width.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: borderRadius(),
            ),
            child: SizedBox(width: double.infinity, child: content),
          ),
        );
      });
}
