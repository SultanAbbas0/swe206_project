import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/reusable_components/text_field_container.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    super.key,
    required this.text,
    required this.textController,
    this.obscureText,
  });
  final String text;
  final TextEditingController textController;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: defaultTextStyle.copyWith(fontSize: 40.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFieldContainer(
          height: 48.h,
          width: 327.w,
          withTextField: true,
          keyboardType: TextInputType.text,
          obscureText: obscureText ?? false,
          textAlign: TextAlign.start,
          textController: textController,
        )
      ],
    );
  }
}
