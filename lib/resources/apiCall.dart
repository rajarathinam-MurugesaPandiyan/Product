import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product/Model/productModel.dart';
import 'package:product/Model/reportListModel.dart';
import 'package:product/Model/reportModel.dart';


class ApiCall {

  Future<List<Products>?> fetchProducts() async {
    var request = await http.get(
        Uri.parse('https://fakestoreapi.com/products'));
    try {
      if (request.statusCode == 200) {
        return productsFromJson(request.body);
      }
      else {
        print(request.statusCode);
      }
    } catch (error, stack) {}
    return null;
  }

  Future<void> setReport(Report value) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:3000/createReport'));
    request.body = json.encode({
      "image": value.image,
      "description": value.description,
      "issueName": value.issueName,
      "orderId": value.orderId,
      "isOpen": true
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<List<ReportList>?> fetchReports() async {
    var request = await http.get(Uri.parse("http://localhost:3000/createReport"));
    List<ReportList> newData = reportListFromJson(request.body) ;
    try {
      if (request.statusCode == 200) {
        return newData;
      }
      else {
        print(request.statusCode);
      }
    } catch (error, stack) {}
    return null;

  }
}
