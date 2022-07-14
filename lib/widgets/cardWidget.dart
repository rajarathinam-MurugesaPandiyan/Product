import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget{
  final String? title;
  final String? image;
  final String? price;
  final int? id;
  final bool? favourites;
  final bool? remover;
  final GestureTapCallback? onCardTap;
  final GestureTapCallback? onFavTap;
  final VoidCallback? addIconTap;

  const CardWidget({
    Key? key ,
    this.title ,
    this.image ,
    this.price,
    this.id,
    this.favourites,
    this.remover,
    this.onCardTap,
    this.addIconTap,
    this.onFavTap
  }) : super(key: key);


  @override
  State<CardWidget> createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
         return InkWell(
           onTap: widget.onCardTap,
           child: Container(
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(5),
                 boxShadow: [
                   BoxShadow(
                       color: Colors.grey.shade600,
                       spreadRadius: 1,
                       blurRadius: 15,
                       offset: const Offset(0, 15)),
                 ]),
             child: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   children: [
                     Stack(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Container(
                             width: 170,
                             height: 170,
                             decoration: const BoxDecoration(
                                 color: Colors.white),
                             child: Image.network(
                                 widget.image!
                             ),
                           ),
                         ),
                         Positioned(
                             right: -15,
                             child:
                             IconButton(
                               onPressed: widget.addIconTap,
                               icon:  Icon( widget.remover ?? false ?  Icons.remove : Icons.add ),
                             )
                         )
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 5),
                       child: Text(
                         widget.title!,
                         overflow: TextOverflow.ellipsis,
                         // maxLines: 2,
                         style: const TextStyle(
                             fontWeight: FontWeight.w700),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 30),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.spaceAround,
                         crossAxisAlignment:
                         CrossAxisAlignment.center,
                         children: [
                           Container(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               "₹ ${widget.price}",
                               style: const TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.w700,
                                   color: Colors.black),
                             ),
                           ),
                           InkWell(
                             onTap:  widget.onFavTap,
                             child: Container(
                               key: ValueKey(widget.id),
                               alignment: Alignment.centerRight,
                               child: Icon(
                                 widget.favourites!
                                     ? Icons.favorite
                                     : Icons.favorite_outline,
                                 color: Colors.blue,
                               ),
                             ),
                           ),
                         ],
                       ),
                     )
                   ],
                 )),
           ),
         );
  }
}