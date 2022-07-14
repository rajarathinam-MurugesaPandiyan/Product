import 'package:equatable/equatable.dart';
import '../../Model/productModel.dart';

class ProductListState extends Equatable{
  final List<Products>? productList;

   ProductListState(
    this.productList
    );

  @override
  List<Object> get props =>[productList??[]];
}

class ProductLoaders extends ProductListState {
  ProductLoaders(super.productList);

}



