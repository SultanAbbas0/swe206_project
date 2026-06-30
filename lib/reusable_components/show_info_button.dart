
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';

class ShowInfoButton extends HookWidget {
  const ShowInfoButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.switchColor,
    this.colorX,
    this.colorY,
    this.n,
    this.tap,
    this.width,
    this.rightMargin,
  });
  final Function onTap;
  final String text;
  final Color? color;
  final bool? switchColor;
  final ValueNotifier? colorX;
  final ValueNotifier? colorY;
  final int? n;
  final ValueNotifier<bool>? tap;
  final double? width;
  final double? rightMargin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap.call();
          if (switchColor == true) {
            if (n == 1) {
              if (colorX!.value == Colors.green) {
                colorX!.value = Colors.grey;
                colorY!.value = Colors.red;
              }
            }
            if (n == 2) {
              if (colorX!.value == Colors.red) {
                colorX!.value = Colors.grey;
                colorY!.value = Colors.green;
              }
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: rightMargin ?? 15.w),
          height: 45.h,
          width: width ?? 95.w,
          decoration: BoxDecoration(
            borderRadius: borderRadius(),
            color:
                switchColor == null ? (color ?? containerColor) : colorX!.value,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: defaultTextStyle,
          ),
        ));
  }
}
