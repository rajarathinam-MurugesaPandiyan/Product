import 'package:equatable/equatable.dart';
import 'package:product/Model/reportListModel.dart';

class ReportListState extends Equatable {

  List<ReportList>? createReport;

  ReportListState(this.createReport);

  @override
  // TODO: implement props
  List<Object?> get props => [createReport];
}
