import 'package:equatable/equatable.dart';
import '../../Model/productModel.dart';

class FavouritesState extends Equatable {
  final List<Products>? productList;
  const FavouritesState(
      this.productList
      );
  @override
  List<Object?> get props =>[productList];
}
class FavouriteLoader extends FavouritesState{
  const FavouriteLoader(super.productList);
}