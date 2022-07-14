import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/ProductDetail/productDetailsEvent.dart';
import '../../Model/productModel.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent , Products>{
  Products? data;
  ProductDetailsBloc(super.initialState){
    on<ProductDetailsEvent>((event ,emit){
      if(event is ProductDetail){
        data = event.singleDetail!;
        emit(data!);
      }
    });
  }

}