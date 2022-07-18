import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/ReportList/ReportListState.dart';
import 'package:product/Screen/ReportList/reportListEvent.dart';

import '../../Model/reportListModel.dart';
import '../../repository/ApiRepository.dart';

class ReportListBloc extends Bloc<ReportListEvent , ReportListState>{

  final ApiRepository _apiCaller = ApiRepository();
  List<ReportList>? data;
  ReportListBloc(super.initialState) {
    on<ReportListEvent>((event, emit) async {
      if (event is InitialReports) {
        data = await _apiCaller.listReports();
        emit(ReportListState(data));
      }
    });
  }


  }