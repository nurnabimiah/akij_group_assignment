


import 'package:meta/meta.dart';
import 'dart:convert';

class PunchListModel {
  final List<PunchListData> data;

  PunchListModel({
    required this.data,
  });

  factory PunchListModel.fromRawJson(String str) => PunchListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PunchListModel.fromJson(Map<String, dynamic> json) => PunchListModel(
    data: List<PunchListData>.from(json["data"].map((x) => PunchListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PunchListData {
  final String id;
  final String userId;
  final String lat;
  final String long;
  final DateTime createdAt;
  final dynamic updatedAt;

  PunchListData({
    required this.id,
    required this.userId,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PunchListData.fromRawJson(String str) => PunchListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PunchListData.fromJson(Map<String, dynamic> json) => PunchListData(
    id: json["id"],
    userId: json["user_id"],
    lat: json["lat"],
    long: json["long"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "lat": lat,
    "long": long,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
