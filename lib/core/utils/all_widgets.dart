import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle boldFont(Color? color, double? size) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
  );
}

TextStyle normalFont(Color? color, double? size) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: size,
  );
}
