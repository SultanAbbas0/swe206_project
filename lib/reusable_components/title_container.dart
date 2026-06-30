import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      width: 200.w,
      height: 35.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius(),
        color: containerColor,
      ),
      child: Text(
        title,
        style: titleTextStyle,
      ),
    );
  }
}
