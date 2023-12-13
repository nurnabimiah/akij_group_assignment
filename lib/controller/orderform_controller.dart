



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/product_item_model.dart';
import '../view/screens/product/order_form.dart';
import '../view/screens/product/product_add_item_screen.dart';

class OrderFormController extends GetxController {
  final RxList<Item> items = <Item>[].obs;
  final RxList<Map<String, dynamic>> allOrders = <Map<String, dynamic>>[].obs;

  void addItem(BuildContext context) async {
    if (items.length < 10) {
      final result = await Get.to(() => AddItemScreen());

      if (result != null && result is Item) {
        items.add(result);
      }
    } else {
      Get.snackbar(
        'Error',
        'You can only add up to 10 items in a single order.',
      );
    }
  }

  void clearItems() {
    items.clear();

  }

}