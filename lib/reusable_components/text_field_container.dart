import 'package:flutter/material.dart';
import 'package:swe206_project/constants.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.height,
    required this.width,
    required this.withTextField,
    this.textController,
    this.child,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.textAlign,
  });
  final double height;
  final double width;
  final bool withTextField;
  final TextEditingController? textController;
  final Widget? child;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: borderRadius()),
      child: withTextField
          ? TextField(
              obscureText: obscureText ?? false,
              controller: withTextField ? textController : null,
              textAlign: textAlign ?? TextAlign.center,
              keyboardType: keyboardType ?? TextInputType.number,
              decoration: const InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
              ),
              style: textFieldTextStyle,
              onChanged: (value) {
                onChanged?.call(value);
              },
            )
          : child,
    );
  }
}
