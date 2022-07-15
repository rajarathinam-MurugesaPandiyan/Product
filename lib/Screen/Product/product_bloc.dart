import 'package:bloc/bloc.dart';
import 'package:product/Model/productModel.dart';
import 'package:product/Screen/Product/ProductState.dart';
import 'package:product/Screen/Product/productEvent.dart';
import 'package:product/repository/ApiRepository.dart';



class ProductBloc extends Bloc<ProductEvent, ProductListState> {
    final ApiRepository _apiCaller = ApiRepository();
    List<Products>? myData = [];

  ProductBloc(super.initialState){
    on<ProductEvent>((event, emit) async {
      if (event is ProductList) {
         myData = await _apiCaller.fetchDetails();
         emit(ProductListState(myData));
      }
      if(event is ProductAscendingSortEvent){
        myData?.sort((a,b)=> a.title!.compareTo(b.title!));
        emit(ProductListState(myData));
      }
      if(event is ProductDescendingSortEvent){
        myData?.sort((a,b)=> b.title!.compareTo(a.title!));
        emit(ProductListState(myData));
      }
      if(event is ProductAllEvent){
        myData!.shuffle();
        emit(ProductListState(myData));
      }
      if(event is AddFavIcon){
        final List<Products> a = [];
        for (int i = 0; i < myData!.length; i++){
          Products product = myData![i];
          if (myData![i].id == event.products.id){
            product = product.copyWith(favourites : !product.favourites!);
          }
          a.add(product);
        }
        emit(ProductListState(a));
        myData = a;
      }
      if(event is ProductRemoveIcon){
        final List<Products> a = [];
        for (int i = 0; i < myData!.length; i++){
          Products product = myData![i];
          if (myData![i].id == event.products!.id){
            product = product.copyWith(remove : !product.remove!);

          }
          a.add(product);
        }
        emit(ProductListState(a));
        myData = a;
      }
      if(event is ProductSearchEvent){
        List<Products> filteredList = [];
        if(event.searchQuery!.isEmpty){
          filteredList.clear();
          emit(ProductListState(myData!));
        }
        for (var e in myData!) {
          if (e.title!.toLowerCase().contains(event.searchQuery!.toLowerCase())) {
            filteredList.add(e);
          }
        }
        emit(ProductListState(filteredList));
      }
      if(event is FinishSearchEvent){
        emit(ProductListState(myData!));
      }
    });
  }
}

