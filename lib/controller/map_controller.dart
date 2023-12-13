



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../data/google_map_response_model.dart';

// class MapController extends GetxController {
//   final punchList = PunchListModel(data: []).obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('https://www.akijpipes.com/api/lat-long/111'));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       punchList(PunchListModel.fromJson(data));
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }



class MapController extends GetxController {


  final punchList = PunchListModel(data: []).obs;


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }



  final double targetLat =  37.7749; // Replace with your target latitude
  final double targetLon =  -122.4194; // Replace with your target longitude

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

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://www.akijpipes.com/api/lat-long/111'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        punchList(PunchListModel.fromJson(data));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  Future<void> punchActionApiCall(double lat, double long) async {
    try {
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
        print('API response: ${response.body}');

      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error as needed
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }





}



