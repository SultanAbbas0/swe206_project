import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const Color scaffoldBackgroundColor = Color(0xFF00573F);

const Color containerColor = Color(0xFFDAC961);

final TextStyle defaultTextStyle = GoogleFonts.aBeeZee(
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  fontSize: 17.sp,
  color: Colors.black,
);
final TextStyle titleTextStyle = GoogleFonts.aBeeZee(
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.italic,
  fontSize: 20.sp,
  color: Colors.black,
);
final TextStyle textFieldTextStyle = GoogleFonts.aBeeZee(
  fontWeight: FontWeight.w400,
  fontSize: 15.sp,
  color: Colors.black,
);

BorderRadius borderRadius({double radius = 12}) {
  return BorderRadius.all(
    Radius.circular(radius),
  );
}
