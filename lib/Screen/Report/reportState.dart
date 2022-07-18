import 'package:equatable/equatable.dart';
import '../../Model/reportModel.dart';

class ReportState extends Equatable{
  Report? reportData;

  ReportState(this.reportData);

  @override
  // TODO: implement props
  List<Object?> get props => [reportData];

}