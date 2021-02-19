import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../text_size.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  accentColor: accentColor,
  splashColor: splashColor,
  disabledColor: disabledColor,
  dividerColor: dividerColor,
  errorColor: errorColor,
  backgroundColor: primaryColorDark,
  scaffoldBackgroundColor: backgroundColor,

  /// Sub themes
  textTheme: _textTheme,
  iconTheme: _iconTheme,
);

TextTheme _textTheme = TextTheme(
  headline2: GoogleFonts.raleway(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
);

IconThemeData _iconTheme = IconThemeData(
  color: accentColor,
  size: 100,
);
