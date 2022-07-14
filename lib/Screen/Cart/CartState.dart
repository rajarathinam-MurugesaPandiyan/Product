import 'package:equatable/equatable.dart';

import '../../Model/productModel.dart';

class CartState extends Equatable{
  final List<Products>? productList;
  CartState(
      this.productList
      );
  @override
  List<Object?> get props =>[productList];
}

class ProductLoader extends CartState{
  ProductLoader(super.productList);
}

