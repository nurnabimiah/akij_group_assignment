
import 'dart:convert';
import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;
import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:assignment_akij/view/screens/map/punch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

import '../../../controller/map_controller.dart';



class CurrentLocationMapScreen extends StatelessWidget {

  static const String routeName ='/map_route';

  final double? latitude, longitude;
  final Position? currentLocation;

  CurrentLocationMapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.currentLocation,
  }) : super(key: key);

  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('Map'),

        actions: [
          TextButton(onPressed: (){
            Get.toNamed(PunchListScreen.routeName);
          },
              child: Text('Punch list',style: myStyleRoboto(16.sp, Colors.white,FontWeight.w600),)
          )
        ],


      ),

      body: SfMaps(
        layers: [
          MapTileLayer(
            zoomPanBehavior: MapZoomPanBehavior(),
            initialFocalLatLng: MapLatLng(
              latitude!, longitude!),
            initialZoomLevel: 9,
            initialMarkersCount: 1,
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                latitude: latitude!,
                longitude:longitude!,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red[800],
                ),
                size: Size(20, 20),
              );
            },
          ),
        ],
      ),

      floatingActionButton: currentLocation != null &&
          mapController.isWithinRadius(currentLocation!, 100.0)
          ? FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          mapController.punchActionApiCall(latitude!, longitude!);
          Get.snackbar(
            'Message',
            'You have punched the button!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue, // Customize the background color
            colorText: Colors.white, // Customize the text color
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      )
          : SizedBox.shrink(),
    );
  }
}
