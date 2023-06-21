import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return GoogleFonts.poppins().copyWith(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getUnderlineTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return _getTextStyle(fontSize, fontWeight, Colors.black);
}

TextStyle getSeeAllTextStyle({
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return _getTextStyle(fontSize, fontWeight, Colors.black);
}

TextStyle getTitleTextStyle({
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return _getTextStyle(fontSize, fontWeight, Colors.black);
}

TextStyle getBlackTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return _getTextStyle(fontSize, fontWeight, Colors.black);
}

TextStyle getWhiteTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return _getTextStyle(fontSize, fontWeight, Colors.white);
}
