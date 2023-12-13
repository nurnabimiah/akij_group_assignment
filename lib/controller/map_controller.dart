



import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../data/google_map_response_model.dart';

class MapController extends GetxController {
  final punchList = PunchListModel(data: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://www.akijpipes.com/api/lat-long/111'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      punchList(PunchListModel.fromJson(data));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

