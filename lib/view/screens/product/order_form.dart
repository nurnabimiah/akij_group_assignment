










import 'package:assignment_akij/utils/app_colors/app_colors.dart';
import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:assignment_akij/view/widgets/custom_textform_filed_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

//
// class OrderForm extends StatefulWidget {
//   @override
//   _OrderFormState createState() => _OrderFormState();
// }
//
// class _OrderFormState extends State<OrderForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController shopNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   List<Item> items = [];
//   List<Map<String, dynamic>> allOrders = [];
//
//   @override
//   void dispose() {
//     shopNameController.dispose();
//     phoneNumberController.dispose();
//
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the shop name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: phoneNumberController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               Text('Items:'),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(items[index].itemName),
//                       subtitle: Text('Quantity: ${items[index].quantity}'),
//                     );
//                   },
//                 ),
//               ),
//               if (items.length < 10)
//                 ElevatedButton(
//                   onPressed: () => _addItem(context),
//                   child: Text('Add Item'),
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _submitOrder(context),
//                 child: Text('Submit Order'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _addItem(BuildContext context) async {
//     if (items.length < 10) {
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AddItemScreen()),
//       );
//
//       if (result != null && result is Item) {
//         setState(() {
//           items.add(result);
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('You can only add up to 10 items in a single order.'),
//         ),
//       );
//     }
//   }
//
//   void _submitOrder(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       Map<String, dynamic> orderData = {
//         'shopName': shopNameController.text,
//         'phoneNumber': phoneNumberController.text,
//         'items': items.map((item) => item.toJson()).toList(),
//       };
//
//       // Add the current order to the list of all orders
//       allOrders.add(orderData);
//
//       // Navigate to OrderSummaryScreen with all orders
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OrderSummaryScreen(allOrders),
//         ),
//       );
//     }
//   }
// }
//
// class AddItemScreen extends StatefulWidget {
//   @override
//   _AddItemScreenState createState() => _AddItemScreenState();
// }
//
// class _AddItemScreenState extends State<AddItemScreen> {
//   TextEditingController itemNameController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: itemNameController,
//                 decoration: InputDecoration(labelText: 'Item Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the item name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the quantity';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _addItem(context),
//                 child: Text('Add Item'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _addItem(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       Navigator.pop(
//         context,
//         Item(
//           itemName: itemNameController.text,
//           quantity: int.parse(quantityController.text),
//         ),
//       );
//     }
//   }
// }
//
// class Item {
//   final String itemName;
//   final int quantity;
//
//   Item({
//     required this.itemName,
//     required this.quantity,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'itemName': itemName,
//       'quantity': quantity,
//     };
//   }
// }
//
//
//
//
//
// class OrderSummaryScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> allOrders;
//
//   OrderSummaryScreen(this.allOrders);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Summary'),
//         actions: [
//           TextButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderForm()));
//           }, child: Text('Back'))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('All Orders:'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: allOrders.length,
//                 itemBuilder: (context, index) {
//                   var orderData = allOrders[index];
//                   String jsonOrder = jsonEncode(orderData);
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Order $index:'),
//                       Text(
//                         jsonOrder,
//                         style: TextStyle(
//                           fontFamily: 'Courier New',
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       Divider(),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/orderform_controller.dart';
import 'order_summary_screen.dart';





class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController shopNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();

    final orderController = Get.find<OrderFormController>();

    @override
  void dispose() {
    // TODO: implement dispose
      shopNameController.dispose();
      phoneNumberController.dispose();
      super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderFormController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Order Form',style: myStyleRoboto(16.sp, Colors.black87,FontWeight.w600),),
            backgroundColor: Colors.blue.withOpacity(0.8),



          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CustomTextFormFiledWidget(
                       controller: shopNameController,
                       hintText: 'Shop Name',
                       textFormFiledValidator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter the shop name';
                         }
                         return null;
                       }),
                  SizedBox(height: 10),
                  CustomTextFormFiledWidget(
                      keybordType: TextInputType.number,
                      controller: phoneNumberController,
                      hintText: 'Phone Number',
                      textFormFiledValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the phone number';
                        }
                        return null;
                      }),

                  SizedBox(height: 10),
                  Text('Items:'),
                  Expanded(
                    child: Obx(
                          () => ListView.builder(
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.items[index].itemName),
                            subtitle:
                            Text('Quantity: ${controller.items[index].quantity}'),
                          );
                        },
                      ),
                    ),
                  ),
                  if (controller.items.length < 10)
                    ElevatedButton(
                      onPressed: () => controller.addItem(context),
                      child: Text('Add Item'),
                    ),
                  SizedBox(height: 20),


                  ElevatedButton(
                   // onPressed: () => controller.submitOrder(context),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> orderData = {
                          'shopName': shopNameController.text,
                          'phoneNumber': phoneNumberController.text,
                          'items': controller.items.map((item) => item.toJson()).toList(),
                        };

                       controller.allOrders.add(orderData);

                        Get.to(() => OrderSummaryScreen(controller.allOrders));
                      }
                    },
                    child: Text('Submit Order'),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
















