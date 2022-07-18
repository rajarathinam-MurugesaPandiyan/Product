import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/Report/reportEvent.dart';
import 'package:product/Screen/Report/reportState.dart';
import '../../Model/reportModel.dart';
import '../../repository/ApiRepository.dart';

class ReportBloc extends Bloc<ReportEvent , ReportState>{

  final ApiRepository _apiCaller = ApiRepository();
  ReportBloc(super.initialState){
    on<ReportEvent>((event ,emit) async {
      if(event is ReportSubmitEvent){
        _apiCaller.updateReport(Report(
          image: event.image,
          description: event.description,
          issueName: event.issueTitle,
          orderId: event.orderId
        ));
      }
    });
  }
}