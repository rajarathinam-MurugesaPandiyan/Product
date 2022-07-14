import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/productDetailsScreen.dart';
import 'package:product/State/ProductState.dart';
import 'package:product/bloc/favourites_bloc.dart';
import 'package:product/bloc/productDetails_bloc.dart';
import 'package:product/bloc/productEvent.dart';
import '../bloc/productDetailsEvent.dart';


class FavouriteScreen extends StatefulWidget{

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreen();

}

class _FavouriteScreen extends State<FavouriteScreen>{

  @override
  void initState(){
    super.initState();
    BlocProvider.of<FavouritesBloc>(context)
        .add(FavouritesAddEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: BlocConsumer<FavouritesBloc , FavouritesState>(
        listener:(context , state){},
        builder:(context , state){
          if(state is FavouritesState){
            return Container(
                decoration: const BoxDecoration(
                    color: Colors.white70
                ),
                child:  GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: state.productList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        InkWell(
                          onTap: (){
                              BlocProvider.of<ProductDetailsBloc>(context).add(ProductDetail(singleDetail: state.productList![index]));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>   ProductDetailsScreen()));
                          },
                          child:  Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        offset: const Offset(0, 15)
                                    ),
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    children: [
                                      Padding(
                                        padding:const EdgeInsets.all(10),
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          decoration: const BoxDecoration(
                                              color: Colors.white
                                          ),
                                          child: Image.network(state.productList![index].image!),
                                        ) ,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "₹ ${state.productList![index].price}" ,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child:  Icon(Icons.star),
                                          ),
                                          Padding(
                                            padding:  const EdgeInsets.only(top: 10),
                                                  child: Text(state.productList![index].rating!.rate.toString())
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                              )
                          ),
                        );
                    }
                )
            );
          }else{
            return Container();
          }
         }
        ),
     );
    }
}