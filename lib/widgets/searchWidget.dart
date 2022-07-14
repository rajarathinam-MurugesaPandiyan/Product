import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget{
  bool condition;
  String? titleString;
  String? inputString;
  ValueChanged<String> onChanged;


   SearchWidget({
     Key? key,
     required this.condition ,
     this.inputString,
     this.titleString,
     required this.onChanged
   }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidget();
}

class _SearchWidget extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.condition
        ? Padding(
           padding: const EdgeInsets.all(10),
           child: TextFormField(
             onChanged: (widget.onChanged),
             style: const TextStyle(color: Colors.white),
             decoration:  InputDecoration(
             border: InputBorder.none,
             hintText: widget.inputString,
               hintStyle: const TextStyle(color: Colors.white),
           ),
         ),
        )
        :  Text(widget.titleString!);
  }
}