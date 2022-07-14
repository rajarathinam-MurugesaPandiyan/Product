import 'package:equatable/equatable.dart';

import '../Model/productModel.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductInital extends ProductEvent{}

class  AddFavIcon extends ProductEvent{
  Products products;

  AddFavIcon({
     required this.products
  });
}

class ProductLoading extends ProductEvent{}

class ProductList extends ProductEvent{

   late final List<Products>? products;

  ProductList( {
    this.products
  });
}



class ProductAscendingSortEvent extends ProductEvent{}

class ProductDescendingSortEvent extends ProductEvent{}

class ProductAllEvent extends ProductEvent{}

class ProductSearchEvent extends ProductEvent{
  final String? searchQuery;

  ProductSearchEvent({
    this.searchQuery
   });
}

class FinishSearchEvent extends ProductEvent{}

class CartInitialEvent extends ProductEvent{
  final List<Products>? cartProducts;

  CartInitialEvent({this.cartProducts});
}

class CartStartEvent extends ProductEvent{}

class ProductAddtoCartEvent extends ProductEvent {
  final Products? product;

  ProductAddtoCartEvent({this.product});
}

class CartItemCountIncreaser extends ProductEvent{
  final Products? product;

  CartItemCountIncreaser({this.product});
}

class CartItemCountDecreaser extends ProductEvent{
  final Products? product;

  CartItemCountDecreaser({this.product});
}

class ProductRemovetoCartEvent  extends ProductEvent{
  final Products? product;

  ProductRemovetoCartEvent({this.product});
}

class CartEvent extends ProductEvent{
  late final Products? product;

  CartEvent({this.product});
}

class CartRemove extends ProductEvent{
  late final Products? product;

  CartRemove({this.product});
}

// Events for the  Favourites Screen
abstract class FavouritesEvent {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class FavouritesInit extends FavouritesEvent{
  final List<Products>? favouriteProducts;
  FavouritesInit({this.favouriteProducts});
}

class FavouritesAddEvent extends FavouritesEvent{}

