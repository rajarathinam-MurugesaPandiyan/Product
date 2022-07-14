import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/Product/ProductState.dart';
import 'package:product/Screen/Favourites/favourites_bloc.dart';
import 'package:product/Screen/ProductDetail/productDetails_bloc.dart';

import '../../Model/productModel.dart';
import '../Cart/CartState.dart';
import '../Cart/cart_bloc.dart';
import '../Product/productEvent.dart';
import '../Product/product_bloc.dart';


class ProductDetailsScreen extends StatefulWidget{



  const ProductDetailsScreen({Key? key}) : super(key: key);


  @override
  State<ProductDetailsScreen> createState() => _ProductDetailScreen();
}

class _ProductDetailScreen extends State<ProductDetailsScreen>{
  Products? condition ;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<ProductDetailsBloc , Products>(
     listener: (context , state){},
     builder: (context , state){
       return Scaffold(
           appBar: AppBar(
             title: Text(state.title.toString()),
             leading: IconButton(
               onPressed: () {
                 BlocProvider.of<FavouritesBloc>(context)
                     .add(FavouritesAddEvent());
                 Navigator.pop(context);
               },
               icon: Icon(Icons.arrow_back_ios_new),
             ),
           ),
           body: SingleChildScrollView(
               physics: const AlwaysScrollableScrollPhysics(),
               child:IntrinsicHeight(
                   child: Column(
                     mainAxisSize: MainAxisSize.max,
                     children:  <Widget> [
                       Padding(
                         padding: const EdgeInsets.all(5),
                         child: Image.network(state.image!),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(25),
                             child: Container(
                               child: Text(
                                 "₹ ${state.price!.toString()}" ,
                                 style: const TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.w700,
                                     fontSize: 40
                                 ),
                               ),
                             ),
                           ),
                           BlocConsumer<ProductBloc , ProductListState>(
                               listener: (context , state){},
                             builder: (context , states){
                                 if(states is ProductListState){
                                   for(var e in states.productList!){
                                     if(e.id == state.id){
                                       condition = e;
                                     }
                                   }
                                   return Padding(
                                     padding: EdgeInsets.all(25),
                                     child: Container(
                                       child: IconButton(
                                         icon: Icon(
                                           condition?.favourites ?? false ?  Icons.favorite : Icons.favorite_outline,
                                           color: Colors.blue,
                                           size: 35,
                                         ),
                                         onPressed: (){
                                             BlocProvider.of<ProductBloc>(context)
                                                 .add(AddFavIcon(
                                               products: state,
                                             ));
                                         },
                                       ),
                                     ),
                                   );
                                 }else{
                                   return Container();
                                 }
                             },
                           ),
                         ],
                       ),

                       BlocConsumer<CartBloc , CartState>(
                           listener: (context , state){},
                           builder: (context , states) {
                             var name;
                             if (states is CartState) {
                               for (var e in states.productList!) {
                                 if (e.id == state.id) {
                                   name = e.itemCount;
                                   print(e.itemCount);
                                 }
                               }
                               return (name == null) ? Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceAround,
                                 children: [
                                   const Text("Add to Cart"),
                                   IconButton(
                                     onPressed: () {


                                       BlocProvider.of<CartBloc>(
                                           context)
                                           .add(ProductAddtoCartEvent(
                                         product: state,
                                       ));

                                       // BlocProvider.of<ProductBloc>(context).add(CartEvent(
                                       //     product: state
                                       //    )
                                       // );
                                       // widget.addToCart!(state);
                                     },
                                     icon: const Icon(
                                         Icons.add_shopping_cart_sharp),
                                   )
                                 ],
                               ) :  Padding(
                                     padding: const EdgeInsets.all(20),
                                      child: Row(
                                          children: [
                                                 IconButton(
                                                    onPressed: (){
                                                      print("monn ${name}");
                                                      if(name == 1){
                                                        BlocProvider.of<CartBloc>(context).add(ProductRemovetoCartEvent(
                                                            product: state
                                                        )
                                                        );
                                                      }
                                                       BlocProvider.of<CartBloc>(context).add(CartItemCountDecreaser(product: state));
                                                     },
                                                     icon: const Icon(Icons.remove)
                                                     ),
                                                 BlocConsumer<CartBloc , CartState>(
                                                     listener: (context , state){},
                                                     builder: (context , states){
                                                     var name;
                                                    if(states is CartState){
                                                        for(var e in states.productList!){
                                                           if(e.id == state.id){
                                                             name = e.itemCount;
                                                             print(name);
                                                             }
                                                         }
                                                     return Text(name.toString());
                                                    }else{return Container();}
                                                   }
                                                 ),

                                                 IconButton(
                                                     onPressed: (){
                                                       BlocProvider.of<CartBloc>(context).add(CartItemCountIncreaser(product: state));},
                                                       icon: const Icon(Icons.add)
                                                      ),
                                                  ],
                                             ),
                                    );
                                }else {
                               return Container();
                              }
                            }
                           ),

                       Padding(
                         padding: EdgeInsets.all(20),
                         child: Container(
                           alignment: Alignment.center,
                           child: Text(
                             state.title!,
                             style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 25
                             ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(20),
                         child: Container(
                           alignment: Alignment.centerLeft,
                           child: const Text(
                             "Description",
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 20
                             ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(25),
                         child: Container(
                           child: Text(
                           state.description!,
                             style: const TextStyle(
                                 color: Colors.grey,
                                 fontSize: 17
                             ),
                           ),
                         ),
                       ),
                     ],
                   )
               )
           )
       );
     },
   );
  }

}