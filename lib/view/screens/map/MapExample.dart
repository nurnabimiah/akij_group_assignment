import 'dart:async';
import 'dart:convert';
import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  final double? latitude,longitude;
  Position? currentLocation;

   MapSample({Key? key, required this.latitude, required this.longitude,required this.currentLocation});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  final double targetLat = 23.7544134; // Replace with your target latitude
  final double targetLon = 90.3788025; // Replace with your target longitude

  bool isWithinRadius(Position position, double radius) {
    double distance = calculateDistance(
        position.latitude, position.longitude, targetLat, targetLon);

    print("Distance from target: $distance");

    return distance <= radius;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000.0; // in meters

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180.0);
  }

  void punchActionApiCall(dynamic lat, dynamic long) async {
    final String apiUrl = 'https://www.akijpipes.com/api/lat-long';
    final int userId = 111; // Replace with the actual user ID

    final Map<String, dynamic> data = {
      'user_id': userId,
      'lat': lat,
      'long': long,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successfully posted data to the API
      print('API response: ${response.body}');
      // Add any additional logic you need after a successful request
    } else {
      // Error occurred during the HTTP request
      print('Failed to post data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SfMaps(
        layers: [
          MapTileLayer(
            zoomPanBehavior: MapZoomPanBehavior(),
            initialFocalLatLng: MapLatLng(
                widget.latitude!, widget.longitude!),
            initialZoomLevel: 9,
            initialMarkersCount: 1,
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                latitude: widget.latitude!,
                longitude: widget.longitude!,
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


      floatingActionButton: widget.currentLocation != null &&
          isWithinRadius(widget.currentLocation!, 100.0) ?
      FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          punchActionApiCall(widget.latitude,widget.longitude);
        },
        child: Icon(Icons.add,color: Colors.white,),
      ):SizedBox.shrink(),

    );
  }

}