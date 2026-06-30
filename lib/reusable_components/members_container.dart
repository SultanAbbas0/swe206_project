import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';

class MembersContainer extends StatelessWidget {
  const MembersContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(),
      ),
      alignment: Alignment.center,
      child: Text(text, style: defaultTextStyle),
    );
  }
}
