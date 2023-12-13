


import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  VoidCallback onTap;
  CustomButton({Key? key,required this.buttonText,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.r))

        ),
        child: Center(child: Text(buttonText, style: myStyleRoboto(16.sp, Colors.black87,FontWeight.w600),)),

      ),
    );
  }
}
