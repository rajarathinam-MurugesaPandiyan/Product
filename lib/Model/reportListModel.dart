// To parse this JSON data, do
//
//     final reportList = reportListFromJson(jsonString);

import 'dart:convert';

List<ReportList> reportListFromJson(String str) => List<ReportList>.from(json.decode(str).map((x) => ReportList.fromJson(x)));

String reportListToJson(List<ReportList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportList {
  ReportList({
    this.image,
    this.description,
    this.issueName,
    this.orderId,
    this.isOpen,
    this.id,
  });

  String? image;
  String? description;
  String? issueName;
  String? orderId;
  bool? isOpen;
  int? id;

  factory ReportList.fromJson(Map<String, dynamic> json) => ReportList(
    image: json["image"],
    description: json["description"],
    issueName: json["issueName"],
    orderId: json["orderId"],
    isOpen: json["isOpen"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "description": description,
    "issueName": issueName,
    "orderId": orderId,
    "isOpen": isOpen,
    "id": id,
  };
}
