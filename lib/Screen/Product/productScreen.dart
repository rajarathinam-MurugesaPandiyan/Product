import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Model/productModel.dart';
import 'package:product/Screen/Cart/CartScreen.dart';
import 'package:product/Screen/Favourites/favouritesScreen.dart';
import 'package:product/Screen/ProductDetail/productDetailsScreen.dart';
import 'package:product/Screen/Product/ProductState.dart';
import 'package:product/Screen/Cart/cart_bloc.dart';
import 'package:product/Screen/Favourites/favourites_bloc.dart';
import 'package:product/Screen/ProductDetail/productDetailsEvent.dart';
import 'package:product/Screen/ProductDetail/productDetails_bloc.dart';
import 'package:product/Screen/Product/productEvent.dart';
import 'package:product/Screen/Product/product_bloc.dart';
import 'package:product/widgets/cardWidget.dart';
import 'package:product/widgets/searchWidget.dart';
import '../Cart/CartState.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

// ignore: constant_identifier_names
enum Menu { All, Ascending, Descending }

class _ProductScreen extends State<ProductScreen> {

  final ScrollController _productScroll  = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(ProductList());
  }

  void _scrollUp(){
    _productScroll.animateTo(
      _productScroll.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _addToCart(Products? value){
      BlocProvider.of<CartBloc>(
          context)
          .add(ProductAddtoCartEvent(
        product: value,
      ));
  }

  Future<bool> _addFavourites(Products? value)async {
        BlocProvider.of<ProductBloc>(context)
          .add(AddFavIcon(
          products: value!,
        ));
      return true;
  }

  bool searchIcon = false;
  late String _selectedMenu;
  bool? forFav;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: SearchWidget(
            onChanged: (value){
               BlocProvider.of<ProductBloc>(context).add(ProductSearchEvent(
                 searchQuery: value
               ));
            },
            condition: searchIcon,
            titleString: "Products",
            inputString: "Search Here",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState((){
                    searchIcon = !searchIcon;
                  });
                  BlocProvider.of<ProductBloc>(context).add(FinishSearchEvent());

                },
                icon: Icon(searchIcon ? Icons.close : Icons.search_outlined)),
            PopupMenuButton<Menu>(
                // Callback that sets the selected popup menu item.
                icon: const Icon(Icons.sort),
                onSelected: (Menu item) {
                  setState(() {
                    _selectedMenu = item.name;
                    if (_selectedMenu == "Ascending") {
                      _scrollUp();
                      BlocProvider.of<ProductBloc>(context)
                          .add(ProductAscendingSortEvent());
                    }
                    if (_selectedMenu == "Descending") {
                      _scrollUp();
                      BlocProvider.of<ProductBloc>(context)
                          .add(ProductDescendingSortEvent());
                    }
                    if (_selectedMenu == "All") {
                      _scrollUp();
                      BlocProvider.of<ProductBloc>(context)
                          .add(ProductAllEvent());
                    }
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.All,
                        child: Text('All'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.Ascending,
                        child: Text('Ascending'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.Descending,
                        child: Text('Descending'),
                      ),
                    ]),
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  const CartScreen()
                            ));
                     },
                    icon: const Icon(Icons.shopping_cart)),
                Positioned(
                    right: 5,
                    top: 5,
                    child:
                    BlocConsumer<CartBloc, CartState>(
                      listener: (context, state) {

                      },
                      builder: (context, state) {
                        if(state is CartState){
                          return
                            (state.productList!.isEmpty) ? Container() :
                            Container(
                              alignment: Alignment.center,
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Text(
                                state.productList!.length.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                        }else{
                          return Container();
                        }
                      },
                    )
                )
              ],
            ),
            IconButton(
              icon: const Icon(Icons.favorite_outlined),
              tooltip: "Favourites",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  FavouriteScreen()
                    ));
              },
            )
          ],
        ),
        body: BlocConsumer<ProductBloc, ProductListState>(
          listener: (context, state) {
            if(state is ProductListState){}
          },
          builder: (context, state) {
            if(state is ProductLoaders){
              return const Center(
                child:  CircularProgressIndicator(
                  color: Colors.blue,
                )
              );
            }
            if(state is ProductListState){
              BlocProvider.of<FavouritesBloc>(context).add(FavouritesInit(favouriteProducts: state.productList));
              BlocProvider.of<CartBloc>(context).add(CartInitialEvent(cartProducts: state.productList));
              return state.productList!.isEmpty ?
              const Center(
                child: Text("No Data Found"),
              ) :
              Container(
                decoration: const BoxDecoration(color: Colors.white70),
                child: GridView.builder(
                  controller: _productScroll,
                  padding: const EdgeInsets.all(20),
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.productList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    forFav = state.productList![index].favourites;
                    return  CardWidget(
                      title: state.productList![index].title,
                      image: state.productList![index].image,
                      price: state.productList![index].price.toString(),
                      favourites: forFav,
                      remover: state.productList![index].remove,
                      onCardTap: () {
                        BlocProvider.of<ProductDetailsBloc>(context).add(ProductDetail(
                            singleDetail: state.productList![index]
                        ));
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ProductDetailsScreen()));
                      },
                      // Add Icon Tap Function
                      addIconTap: () {
                        setState((){
                          state.productList![index].remove =  !state.productList![index].remove!;
                        });
                        if(state.productList![index].remove!){
                          _addToCart(state.productList![index]);
                        }else{
                          BlocProvider.of<CartBloc>(context).add(ProductRemovetoCartEvent(
                              product: state.productList![index]
                             )
                          );
                        }
                      },
                      // fav button functions
                      onFavTap: () {
                           _addFavourites(state.productList![index]);
                      },
                    );
                  },
                ),
              );
            }else{
              return Container();
            }
              },
        )
     );
  }
}
