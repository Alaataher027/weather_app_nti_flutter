import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
  });

  final String hint;
  final int maxLines;
  final Function(String?)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 42.h,
        child: TextFormField(
          onChanged: onChanged,
          onSaved: onSaved,
          onFieldSubmitted: onSubmitted,
          cursorColor: myTextColor(context),
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color:
                  isDark(context)
                      ? const Color.fromARGB(203, 210, 209, 209)
                      : const Color.fromARGB(255, 133, 133, 133),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: myTextColor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: myTextColor(context)),
            ),
          ),
        ),
      ),
    );
  }
}
