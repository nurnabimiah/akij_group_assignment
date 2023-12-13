



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/orderform_controller.dart';
import '../../../utils/app_textstyle/app_text_style.dart';
import 'order_form.dart';

class OrderSummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> ? allOrders;
  OrderSummaryScreen(this.allOrders);




  @override
  Widget build(BuildContext context) {
    final OrderFormController controller = Get.find<OrderFormController>();
    // Use the controller to get the allOrders list
    List<Map<String, dynamic>> allOrders = controller.allOrders;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Order Summary'),
        actions: [
          TextButton(
            onPressed: () {
              Future.microtask(() {
                controller.clearItems();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OrderForm();
                }));
              });
            },
            child: Text('Back'),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('All Orders:',  style: myStyleRoboto(14.sp,Colors.black87,FontWeight.w600)),
            Expanded(
              child: ListView.builder(
                itemCount: allOrders.length,
                itemBuilder: (context, index) {
                  var orderData = allOrders[index];
                  String jsonOrder = jsonEncode(orderData);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ${index + 1}:',
                          style: myStyleRoboto(16.sp,Colors.black87,FontWeight.w600)
                      ),
                      Text(
                          jsonOrder,
                          style: myStyleRoboto(12.sp,Colors.black87,FontWeight.w500)
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}