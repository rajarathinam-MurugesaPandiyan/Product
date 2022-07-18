import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product/Screen/Report/reportBloc.dart';
import 'package:product/Screen/Report/reportEvent.dart';
import 'package:product/Screen/Report/reportState.dart';
import 'package:product/Screen/ReportList/reportListScreen.dart';


class ReportScreen extends StatefulWidget{
  const ReportScreen({Key? key}) : super(key: key);


  @override
  State<ReportScreen> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {

  File path = File("");
  bool condition = false;
  bool deleteCondition = false;
  TextEditingController issueController = TextEditingController();
  TextEditingController orderId = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> _getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image,);
    if (result != null) {
      setState((){
        path = File(result.files.single.path!);
        deleteCondition = !deleteCondition;
      });
    } else {
      // User canceled the picker
    }
   // BlocProvider.of<ReportBloc>(context).add(ReportImageAdd());
  }

  Future<void> _getPhotoFromCamera() async {
    final ImagePicker  imageCapturer = ImagePicker();
    
    final XFile? cameraImage = await imageCapturer.pickImage(source: ImageSource.camera);
    setState((){
      path = File(cameraImage!.path);
    });
    print(cameraImage?.path);
  }

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         title: const Text("Report"),
         actions: [
           IconButton(
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const ReportListScreen()));
               },
               icon: const Icon(Icons.mail_sharp)
           )
         ],
       ),
       body:
           SingleChildScrollView(
             scrollDirection: Axis.vertical,
             physics: const ScrollPhysics(),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                     padding: const EdgeInsets.all(20),
                   child: TextFormField(
                     controller: issueController,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                         label: Text("Issue Faced")
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20),
                   child: Container(
                    child: TextFormField(
                      controller: orderId,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Order Id")
                      ),
                    ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20),
                   child: TextFormField(
                     controller: description,
                     decoration: const InputDecoration(
                         label: Text("Description")
                     ),
                   ),
                 ),
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(20),
                       child: Container(
                         width: 50,
                         height: 50,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border:  Border.all(
                               width: 1,
                               color: Colors.black,
                               style: BorderStyle.solid
                           ),
                         ),
                         child: Center(
                           child: IconButton(
                             onPressed: (){
                                 if(deleteCondition == true){
                                    setState((){
                                      path = File("");
                                      deleteCondition = !deleteCondition;
                                    });
                                 }else{
                                   _getImage();
                                 }

                             },
                             icon:  Icon( (deleteCondition) ? Icons.delete_forever_rounded : Icons.add),
                             iconSize: 30,
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.all(10),
                       child: (deleteCondition) ?  const Text("Delete Image") :  const Text("Attach Image") ,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(20),
                       child: Container(
                         width: 50,
                         height: 50,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border:  Border.all(
                               width: 1,
                               color: Colors.black,
                               style: BorderStyle.solid
                           ),
                         ),
                         child: Center(
                           child: IconButton(
                             onPressed: (){

                               _getPhotoFromCamera();
                             },
                             icon:  Icon( Icons.camera ),
                             iconSize: 30,
                           ),
                         ),
                       ),
                     ),
                     const Padding(
                       padding: EdgeInsets.all(10),
                       child:  Text("Take Photo") ,
                     ),
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20) ,
                   child:  BlocBuilder<ReportBloc , ReportState>(

                       builder: (context , state){
                         return SizedBox(
                           width: MediaQuery.of(context).size.width/1,
                           height: 300,
                           child: path.path.isEmpty ?
                           Container():
                           Image.file(
                             width: MediaQuery.of(context).size.width/4,
                             height: 100,
                              path,
                           ) ,
                         );
                       }
                   ) ,
                 )
               ],
             ),
           ),
         floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                if(orderId.text.isNotEmpty){
                  List<int> imageBytes = path.readAsBytesSync();
                  String baseValue = base64Encode(imageBytes);
                  BlocProvider.of<ReportBloc>(context).add(ReportSubmitEvent(
                      image: baseValue,
                      description: description.text,
                      issueTitle: issueController.text,
                      orderId: orderId.text
                  ));
                  setState((){
                    path = File("");
                    description.text = "";
                    issueController.text = "";
                    orderId.text = "";
                    deleteCondition = !deleteCondition;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Submitted Successfully"),
                  ));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OrderId is Mandatory"),
                  ));
                }
           },
              label: const Text("Submit"),
          ),
     );
  }
}