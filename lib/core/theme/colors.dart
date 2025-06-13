import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';

Color myTextColor(BuildContext context) {
  return isDark(context) ? const Color(0xFFF6F4E8) : const Color(0xFF2B2B2A);
}

const myWhite = Color.fromARGB(255, 244, 241, 223);
const myBlack = Color(0xFF2B2B2A);
