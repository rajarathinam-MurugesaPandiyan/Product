import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget{
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onchange;
  final int? maximum;


  const InputWidget({
    Key? key ,
    this.controller ,
    this.placeholder,
    this.maximum,
    this.onchange
  }) : super(key: key);





  @override
  State<InputWidget> createState() => _InputWidget();
}

class _InputWidget  extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
     return
     Container(
       padding: EdgeInsets.all(20),
       width: MediaQuery.of(context).size.width/1,
       child:   TextFormField(
         decoration:  InputDecoration(
           border: const OutlineInputBorder(),
           label: Text(widget.placeholder ?? ""),
         ),
         controller: widget.controller,
         onChanged: widget.onchange,
         inputFormatters: [
           LengthLimitingTextInputFormatter(widget.maximum),
         ],
         style: const TextStyle(
             color:  Colors.black
         ),
       ),
     );

  }


}