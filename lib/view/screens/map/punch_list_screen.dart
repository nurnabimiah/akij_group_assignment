


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/map_controller.dart';


class PunchListScreen extends StatelessWidget {
  static const String routeName = '/punch_list_route';
  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Punch List Screen'),
      ),
      body: Obx(() {
        if (mapController.punchList.value.data.isEmpty) {
          // Data not loaded yet or empty, show loading indicator or a message
          return Center(
            child: mapController.punchList.value.data.isEmpty
                ? CircularProgressIndicator()
                : Text('No punch list data available.'),
          );
        } else {
          // Data is loaded and not empty, display the list
          return ListView.builder(
            itemCount: mapController.punchList.value.data.length,
            itemBuilder: (context, index) {
              final punchListData = mapController.punchList.value.data[index];
              return ListTile(
                title: Text('ID: ${punchListData.id}'),
                subtitle: Text('Lat: ${punchListData.lat}, Long: ${punchListData.long}'),
              );
            },
          );
        }
      }),
    );
  }
}

