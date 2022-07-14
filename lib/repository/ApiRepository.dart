import 'package:product/Model/productModel.dart';
import 'package:product/resources/apiCall.dart';


class ApiRepository {
  final _provider = ApiCall();


  Future<List<Products>?> fetchDetails() {
    return _provider.fetchProducts();
  }
}

class NetworkError extends Error {}