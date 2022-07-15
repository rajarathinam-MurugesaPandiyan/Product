import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Model/productModel.dart';
import 'package:product/Screen/Payment/paymentBloc.dart';
import 'package:product/Screen/Product/productScreen.dart';
import 'package:product/Screen/Product/ProductState.dart';
import 'package:product/Screen/Cart/cart_bloc.dart';
import 'package:product/Screen/Favourites/favourites_bloc.dart';
import 'package:product/Screen/ProductDetail/productDetails_bloc.dart';
import 'package:product/Screen/Product/product_bloc.dart';
import 'Screen/Cart/CartState.dart';
import 'Screen/Favourites/FavouritesState.dart';
import 'Screen/Payment/paymentState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(create: (context) => ProductBloc(ProductLoaders([]))),
          BlocProvider<FavouritesBloc>(create: (context) => FavouritesBloc(const FavouriteLoader([]))),
          BlocProvider<CartBloc>(create: (context) => CartBloc(ProductLoader([]))),
          BlocProvider<ProductDetailsBloc>(create: (context) => ProductDetailsBloc(Products())),
          BlocProvider<PaymentBloc>(create: (context) => PaymentBloc(PaymentLoad(""))),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  const ProductScreen(),
        ),
      );
  }
}

