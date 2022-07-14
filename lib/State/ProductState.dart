import 'package:equatable/equatable.dart';
import '../Model/productModel.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props =>[];
}

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

class ProductLoader extends CartState{
  ProductLoader(super.productList);
}

class FavouritesState extends Equatable {
   final List<Products>? productList;
  FavouritesState(
      this.productList
      );
  @override
  List<Object?> get props =>[productList];
}
class FavouriteLoader extends FavouritesState{
  FavouriteLoader(super.productList);
}

class CartState extends Equatable{
  final List<Products>? productList;
  CartState(
      this.productList
      );
  @override
  List<Object?> get props =>[productList];
}