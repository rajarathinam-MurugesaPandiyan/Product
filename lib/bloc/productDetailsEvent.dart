import '../Model/productModel.dart';

abstract class ProductDetailsEvent {
  const ProductDetailsEvent();

  List<Object?> get props => [];
}


class ProductDetail extends ProductDetailsEvent{
   final Products? singleDetail;

   ProductDetail({
     this.singleDetail
   });
}