import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/ReportList/ReportListBloc.dart';
import 'package:product/Screen/ReportList/ReportListState.dart';
import 'package:product/Screen/ReportList/reportListEvent.dart';

class ReportListScreen extends StatefulWidget{
  const ReportListScreen({Key? key}) : super(key: key);


  @override
  State<ReportListScreen> createState() => _ReportListScreen();
}

class _ReportListScreen extends State<ReportListScreen>{

  @override
  void initState(){
    super.initState();
    print("hello");
    BlocProvider.of<ReportListBloc>(context).add(InitialReports());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: const Text("Your Reports"),
       ),
      body:Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child:  BlocBuilder<ReportListBloc , ReportListState>(
                builder: (context , state){
                  if(state.createReport!.isEmpty){
                    return Container();
                  }
                  print(state.createReport![0]);
                  return Text(state.createReport![0].description!);
                },
              ),
            )
          ],
        ),
      )

    );
  }
}