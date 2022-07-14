import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/State/ProductState.dart';
import 'package:product/bloc/cart_bloc.dart';
import 'package:product/bloc/productEvent.dart';



class CartScreen extends StatefulWidget{

  const CartScreen({Key? key,}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen  extends State<CartScreen>{

   @override
   void initState(){
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent
        ),
        height: MediaQuery.of(context).size.height/1.19,
         child : BlocConsumer<CartBloc , CartState>(
          listener: (context , state){},
          builder: (context , state){
            if(state is CartState){
              return ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: state.productList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    (state.productList!.isEmpty) ? Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
                      child: const Center(
                        child: Text(""),
                      ),
                    ) :
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/8,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        offset: const Offset(0, 15)),
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width : 30,
                                      child: Image.network(state.productList![index].image!)
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width/2,
                                    child:   Text(state.productList![index].title!,
                                        style: const TextStyle(
                                          color: Colors.black ,
                                        )
                                    ),
                                  ),
                                   Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Text((state.productList![index].price!*state.productList![index].itemCount!).round().toString()),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  IconButton(
                                                      onPressed: (){
                                                        if(state.productList![index].itemCount == 1){
                                                            BlocProvider.of<CartBloc>(context).add(ProductRemovetoCartEvent(
                                                                product: state.productList![index]
                                                              )
                                                            );
                                                          }
                                                          BlocProvider.of<CartBloc>(context).add(CartItemCountDecreaser(
                                                              product: state.productList![index]
                                                              )
                                                          );
                                                      },
                                                      icon: const Icon(Icons.remove)
                                                  ),
                                                  Text(state.productList![index].itemCount.toString()),
                                                  IconButton(
                                                      onPressed: (){
                                                        BlocProvider.of<CartBloc>(context).add(CartItemCountIncreaser(
                                                            product: state.productList![index]
                                                           )
                                                        );
                                                      },
                                                      icon: const Icon(Icons.add)
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                   ],
                               ),
                            )
                          ],
                        )
                    );
                },
              );
            }else{
              return Container(
                child: const Text("There is no Products in the cart"),
              );
            }
        },
       ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

        },
        label: const Text("CheckOut"),
      ),
    );
  }
}