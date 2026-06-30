import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/reusable_components/show_info_button.dart';

class InfoContainer extends HookWidget {
  const InfoContainer({
    super.key,
    required this.title,
    required this.onTap1,
    required this.onTap2,
    this.content,
    this.text1,
    this.text2,
    this.color1,
    this.color2,
    this.switchColor,
    this.onTap3,
    this.text3,
    this.color3,
    this.isSelected,
  });
  final String title;
  final String? content;
  final Function onTap1;
  final Function onTap2;
  final String? text1;
  final String? text2;
  final Color? color1;
  final Color? color2;
  final bool? switchColor;
  final Function? onTap3;
  final String? text3;
  final Color? color3;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final tap = useState(false);
    final colorX1 = useState(isSelected == true ? Colors.grey : Colors.green);
    final colorX2 = useState(isSelected == true ? Colors.red : Colors.grey);
    final buttonWidth = text3 != null ? 80.w : 95.w;
    final buttonMargin = text3 != null ? 6.w : 15.w;

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: borderRadius(),
        color: Colors.white,
      ),
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20.w),
              child: Text(
                title,
                style: defaultTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (content != null)
            Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  content!,
                  style: defaultTextStyle,
                )),
          if (text1 != null || text2 != null)
            Row(
              children: [
                if (text1 != null)
                  ShowInfoButton(
                    onTap: onTap1,
                    text: text1!,
                    color: color1,
                    switchColor: switchColor,
                    colorX: colorX1,
                    colorY: colorX2,
                    tap: tap,
                    n: 1,
                    width: buttonWidth,
                    rightMargin: buttonMargin,
                  ),
                if (text2 != null)
                  ShowInfoButton(
                    onTap: onTap2,
                    text: text2!,
                    color: color2,
                    switchColor: switchColor,
                    colorX: colorX2,
                    colorY: colorX1,
                    tap: tap,
                    n: 2,
                    width: buttonWidth,
                    rightMargin: buttonMargin,
                  ),
                if (text3 != null)
                  ShowInfoButton(
                    onTap: onTap3 ?? () {},
                    text: text3!,
                    color: color3,
                    width: buttonWidth,
                    rightMargin: buttonMargin,
                  ),
              ],
            )
        ],
      ),
    );
  }
}
