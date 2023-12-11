

import 'package:assignment_akij/view/screens/product_order_screen/product_order_screen.dart';
import 'package:assignment_akij/view/screens/qrcode/qrcode_screen.dart';
import 'package:assignment_akij/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home_route';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('Home'),
        centerTitle: true,
      ),


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:20.w),
        child: Column(
          children: [
            SizedBox(height: 250.h,),
            //........qr code scan..............................................
            CustomButton(
              buttonText: 'Scan Qr Code',
              onTap: () { Get.toNamed(QrcodeScreen.routeName);  },),
            SizedBox(height: 15.h,),

            //............google map............................................
            CustomButton(buttonText: 'Google Map', onTap: () {  },),
            SizedBox(height: 15.h,),


            CustomButton(buttonText: 'Product Order', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderForm()));
            },),



          ],
        ),
      ),


    );
  }
}
