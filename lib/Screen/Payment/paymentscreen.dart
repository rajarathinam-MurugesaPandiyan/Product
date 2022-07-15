import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/Payment/paymentBloc.dart';
import 'package:product/Screen/Payment/paymentState.dart';
import 'package:product/Screen/Payment/paymentevent.dart';
import 'package:product/widgets/inputWidget.dart';

import '../../Model/ObjectModel.dart';

class PaymentScreen extends StatefulWidget{

  @override
  State<PaymentScreen> createState() => _PaymentScreen();

}

class _PaymentScreen extends State<PaymentScreen> {

   List<ObjectModel>? paymentScreenItems = [
    ObjectModel(imageUrl: "https://pbs.twimg.com/profile_images/1329113828731146242/FzxBBPrs_400x400.jpg",
    title: "Google Pay"),
    ObjectModel(imageUrl: "https://play-lh.googleusercontent.com/6iyA2zVz5PyyMjK5SIxdUhrb7oh9cYVXJ93q6DZkmx07Er1o90PXYeo6mzL4VC2Gj9s",
    title: "PhonePe"),
    ObjectModel(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/00/7d/9e/007d9e5f-a2df-cb4d-75bc-b6f6aeada016/AppIcon-0-0-1x_U007emarketing-0-0-0-8-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/1200x600wa.png", title: "PhonePe")
  ];




  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {

       return Scaffold(
         appBar: AppBar(
           title: const Text("Payment"),
         ),
         body: Container(
           decoration: const BoxDecoration(
             color: Colors.white
           ),
           child:  Column(
             children: [
               InputWidget(
                 maximum: 10,
                 placeholder: "Enter Your Mobile Number",
                 controller: _mobileController,
                 onchange: (value){
                    BlocProvider.of<PaymentBloc>(context).add(PaymentNumber(phoneNumber: value));
                 },
               ),
               InputWidget(
                 placeholder: "Enter Your Billing Address",
                 controller: _addressController,
               ),
               Container(
                 height: 400,
                 child:  ListView.builder(
                     itemCount: paymentScreenItems!.length,
                     itemBuilder: (context  , index){
                       return  Padding(
                         padding: const EdgeInsets.all(20),
                         child: Container(
                           width: MediaQuery.of(context).size.width,
                           height: 80,
                           decoration :  BoxDecoration(
                             color: Colors.white,
                             border: Border.all(color: Colors.blue),
                             borderRadius: BorderRadius.circular(3),
                           ),
                           child: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(10),
                                 child:  CircleAvatar(
                                   radius: 30,
                                   backgroundImage: NetworkImage(paymentScreenItems![index].imageUrl ?? ""),
                                 ) ,
                               ),
                               BlocBuilder<PaymentBloc, PaymentState>(
                                   builder: (context , state){
                                     return  Padding(
                                       padding: EdgeInsets.all(10),
                                       child: Text("${paymentScreenItems![index].title}  ${state.phoneNumber}"),
                                     );
                                   }
                               ),
                             ],
                           ),
                         ) ,
                       );
                     }
                 ),
               )
             ],
           ),
         )
       );
  }


}