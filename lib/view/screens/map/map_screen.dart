



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late Position currentPosition;
  late bool showSubmitButton;

  @override
  void initState() {
    super.initState();
    showSubmitButton = false;
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = position;
      showSubmitButton = _isWithin100mOfAkijHouse(position);
    });
  }

  bool _isWithin100mOfAkijHouse(Position position) {
    double akijHouseLat = 37.7749;
    double akijHouseLong = -122.4194;

    double userLat = position.latitude;
    double userLong = position.longitude;

    double distance = _calculateHaversineDistance(
      akijHouseLat,
      akijHouseLong,
      userLat,
      userLong,
    );

    return distance < 0.1; // Assuming distance is in kilometers, adjust as needed
  }



  double _calculateHaversineDistance(
      double startLat,
      double startLong,
      double endLat,
      double endLong,
      ) {
    const double radiusOfEarth = 6371.0;

    double lat1 = startLat * (pi / 180.0);
    double lon1 = startLong * (pi / 180.0);
    double lat2 = endLat * (pi / 180.0);
    double lon2 = endLong * (pi / 180.0);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radiusOfEarth * c;
  }


  void _submitPunch() async {
    final response = await http.post(
      Uri.parse('https://www.akijpipes.com/api/lat-long'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
      '{"user_id": "111", "lat": ${currentPosition.latitude}, "long": ${currentPosition.longitude}}',
    );

    if (response.statusCode == 200) {
      print('Punch submitted successfully');
    } else {
      print('Failed to submit punch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akij Pipes'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 15.0,
            ),
          ),
          if (showSubmitButton)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: _submitPunch,
                child: Text('Submit Punch'),
              ),
            ),
        ],
      ),
    );
  }
}
