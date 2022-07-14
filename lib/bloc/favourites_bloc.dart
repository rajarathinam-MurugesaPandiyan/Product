import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/bloc/productEvent.dart';
import '../Model/productModel.dart';
import '../State/ProductState.dart';


class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {

  List<Products>? favourites;

  FavouritesBloc(super.initialState) {
    on<FavouritesEvent>((event, emit)  {
      if(event is FavouritesInit){
        favourites = event.favouriteProducts;
      }
      if(event is FavouritesAddEvent)  {
          List<Products> favData = [];
         for(var e in favourites!){
           if(e.favourites == true){
             favData.add(e);
           }else{
             favData.remove(e);
           }
         }
         emit(FavouritesState(favData));
      }
    });
  }
}