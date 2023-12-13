



import 'package:assignment_akij/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_textstyle/app_text_style.dart';

class AddItemButton extends StatelessWidget {
  String buttonText;
  VoidCallback onTap;
  AddItemButton({Key? key,required this.buttonText,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(10.r))

        ),
        child: Center(child: Text(buttonText, style: myStyleRoboto(16.sp, AppColors.appWhiteColor,FontWeight.w600),)),

      ),
    );
  }
}
