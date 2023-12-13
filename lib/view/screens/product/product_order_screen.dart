



/*

import 'package:assignment_akij/view/widgets/custom_button_widget.dart';
import 'package:assignment_akij/view/widgets/custom_textform_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_textstyle/app_text_style.dart';
import '../../widgets/add_item_button.dart';
import 'dart:convert';



class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<Item> items = [];


  @override
  void dispose() {
    shopNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('Order Form'),
        centerTitle: true,
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///............shop Name.........................

              CustomTextFormFiledWidget(
                  controller: shopNameController,
                  hintText: 'Shop Name',
                  textFormFiledValidator:(value){
                    if(value==null || value.isEmpty){
                      return 'Please enter the shop name';
                    }

                  }

              ),
              SizedBox(height: 10.h,),

              ///............Phone number.........................
              CustomTextFormFiledWidget(
                  keybordType: TextInputType.number,
                  controller: phoneNumberController,
                  hintText: 'Phone Number',
                  textFormFiledValidator:(value){
                    if(value==null || value.isEmpty){
                      return 'Please enter the phone number';
                    }

                  }

              ),
              SizedBox(height: 10.h,),


              ///.............Add item button.........................
              AddItemButton(
                  buttonText: 'Add Item',
                  onTap: (){
                    _addItem(context);
                  }
              ),



              SizedBox(height: 10),
              Text('Items:',style: myStyleRoboto(16.sp, AppColors.appWhiteColor,FontWeight.w600)),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].itemName),
                      subtitle: Text('Quantity: ${items[index].quantity}'),
                    );
                  },
                ),
              ),


              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitOrder(context),
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _addItem(BuildContext context) async {
    if (items.length < 1) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddItemScreen()),
      );

      if (result != null && result is Item) {
        setState(() {
          items.add(result);
        });
      }
    } else {
      // Show a message or dialog indicating that only 10 items are allowed.
      // You can use Flutter's built-in dialog or a Snackbar for this purpose.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add up to 10 items in a single order.'),
        ),
      );
    }
  }



}




class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addItem(context),
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }




void _addItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Item(
          itemName: itemNameController.text,
          quantity: int.parse(quantityController.text),
        ),
      );
    }
  }
}


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

// class OrderSummaryScreen extends StatelessWidget {
//   final Map<String, dynamic> orderData;
//
//   OrderSummaryScreen(this.orderData);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Summary'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Shop Name: ${orderData['shopName']}'),
//             Text('Phone Number: ${orderData['phoneNumber']}'),
//             Text('Items:'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: orderData['items'].length,
//                 itemBuilder: (context, index) {
//                   var item = orderData['items'][index];
//                   return ListTile(
//                     title: Text(item['itemName']),
//                     subtitle: Text('Quantity: ${item['quantity']}'),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Back to Form'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class Item {
  final String itemName;
  final int quantity;

  Item({
    required this.itemName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemName: json['itemName'],
      quantity: json['quantity'],
    );
  }
}



class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  OrderSummaryScreen(this.orderData);

  @override
  Widget build(BuildContext context) {
    // Extract shop name, phone number, and items from orderData
    String shopName = orderData['shopName'];
    String phoneNumber = orderData['phoneNumber'];
    List<Item> items = (orderData['items'] as List<dynamic>)
        .map((item) => Item.fromJson(item))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shop Name: $shopName'),
            Text('Phone Number: $phoneNumber'),
            Text('Items:'),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Item item = items[index];
                  return ListTile(
                    title: Text(item.itemName),
                    subtitle: Text('Quantity: ${item.quantity}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Form'),
            ),
          ],
        ),
      ),
    );
  }
}
*/




// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../utils/app_colors/app_colors.dart';
// import '../../../utils/app_textstyle/app_text_style.dart';
// import '../../widgets/add_item_button.dart';
// import '../../widgets/custom_textform_filed_widget.dart';
//
//
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
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.withOpacity(0.8),
//         title: Text('Order Form'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomTextFormFiledWidget(
//                 controller: shopNameController,
//                 hintText: 'Shop Name',
//                 textFormFiledValidator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the shop name';
//                   }
//                 },
//               ),
//               SizedBox(height: 10.h,),
//               CustomTextFormFiledWidget(
//                 keybordType: TextInputType.number,
//                 controller: phoneNumberController,
//                 hintText: 'Phone Number',
//                 textFormFiledValidator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the phone number';
//                   }
//                 },
//               ),
//               SizedBox(height: 10.h,),
//               AddItemButton(
//                 buttonText: 'Add Item',
//                 onTap: () {
//                   _addItem(context);
//                 },
//               ),
//               SizedBox(height: 10),
//               Text('Items:', style: myStyleRoboto(16.sp, AppColors.appWhiteColor, FontWeight.w600)),
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
//       allOrders.add(orderData);
//
//       // Clear form fields and items list for the next order
//       shopNameController.clear();
//       phoneNumberController.clear();
//       items.clear();
//
//       Navigator.pushReplacement(
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
//
//       // Clear form fields for the next item
//       itemNameController.clear();
//       quantityController.clear();
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
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       itemName: json['itemName'],
//       quantity: json['quantity'],
//     );
//   }
// }
//
// class OrderSummaryScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> allOrders;
//
//   OrderSummaryScreen(this.allOrders);
//
//   @override
//   State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
// }
//
//
// class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
//
//   @override
//   void initState() {
//     print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>cheack >>>>>>${widget.allOrders.length}');
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Summary'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Raw JSON for Each Order:'),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.allOrders.length,
//                 itemBuilder: (context, index) {
//                   String rawJson = jsonEncode(widget.allOrders[index]);
//                   return Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         rawJson,
//                         style: TextStyle(fontFamily: 'Courier New', fontSize: 14),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Back to Form'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


