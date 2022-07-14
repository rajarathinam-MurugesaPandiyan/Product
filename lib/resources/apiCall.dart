import 'package:http/http.dart' as http;
import 'package:product/Model/productModel.dart';


class ApiCall {

  Future<List<Products>?> fetchProducts() async{
    var request =  await http.get(Uri.parse('https://fakestoreapi.com/products'));
    try {
      if (request.statusCode == 200) {
        return productsFromJson(request.body);
      }
      else {
        print(request.statusCode);
      }
    }catch(error , stack){}
    return null;
  }

}
