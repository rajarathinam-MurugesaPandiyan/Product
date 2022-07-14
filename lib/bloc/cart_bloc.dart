import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/State/ProductState.dart';
import 'package:product/bloc/productEvent.dart';
import '../Model/productModel.dart';

class CartBloc extends Bloc<ProductEvent, CartState> {

  List<Products> cartItems = [];
  CartBloc(super.initialState) {
    on<ProductEvent>((event, emit) {
       if(event is ProductAddtoCartEvent){
           if(! cartItems.contains(event.product)){
               cartItems = [...cartItems , event.product!];
               emit(CartState(cartItems));
           }
        }
       if(event is CartItemCountIncreaser){
           final List<Products> a = [];
           for (int i = 0; i < cartItems.length; i++){
               Products product = cartItems[i];
               if (cartItems[i].id == event.product!.id){
                  product = product.copyWith(itemCount : product.itemCount! + 1);
               }
             a.add(product);
           }
           emit(CartState(a));
           cartItems = a;
       }
       if(event is CartItemCountDecreaser){
           final List<Products> a = [];
           for (int i = 0; i < cartItems.length; i++){
               Products product = cartItems[i];
               if (cartItems[i].id == event.product!.id){
                    product = product.copyWith(itemCount : product.itemCount! - 1);
               }
              a.add(product);
           }
          emit(CartState(a));
          cartItems = a;
       }
       if (event is ProductRemovetoCartEvent) {
          final List<Products> a = [];
          for (int i = 0; i < cartItems.length; i++){
             Products product = cartItems[i];
             a.add(product);
            if (cartItems[i].id == event.product!.id){
               a.remove(product);
            }
          }
         emit(CartState(a));
         cartItems = a;
       }
    });
  }
}
