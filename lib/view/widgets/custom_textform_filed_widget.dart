import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_textstyle/app_text_style.dart';

class CustomTextFormFiledWidget extends StatelessWidget {


  CustomTextFormFiledWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textFormFiledValidator,
    this.obscureText = false,
    this.suffixIcon,
    this.keybordType
  }) : super(key: key);

  TextEditingController controller = TextEditingController();
  String hintText;
  String? Function(String?) textFormFiledValidator;
  bool obscureText;
  Widget? suffixIcon;
  TextInputType? keybordType;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keybordType ,
      validator: textFormFiledValidator,
      style: myStyleRoboto(16.sp, AppColors.appWhiteColor, FontWeight.w400),
      cursorColor: AppColors.appWhiteColor,
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: myStyleRoboto(15.sp, AppColors.appWhiteColor, FontWeight.w600),
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          fillColor: Colors.black45,
          //fillColor: AppColors.lipizLazualiColor.withOpacity(0.8),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0,),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0,),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0), // Set error border color to white
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),

          errorStyle: myStyleRoboto(12.sp, Colors.red, FontWeight.w400),


      ),



    );
  }
}
