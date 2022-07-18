import 'package:product/Model/productModel.dart';
import 'package:product/Model/reportListModel.dart';
import 'package:product/Model/reportModel.dart';
import 'package:product/resources/apiCall.dart';


class ApiRepository {
  final _provider = ApiCall();


  Future<List<Products>?> fetchDetails() {
    return _provider.fetchProducts();
  }
  Future<void> updateReport(Report value) {
    return _provider.setReport(value);
  }
  Future<List<ReportList>?> listReports() {
    return  _provider.fetchReports();
  }
}

class NetworkError extends Error {}