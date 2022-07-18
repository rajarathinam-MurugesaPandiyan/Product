import 'package:product/Model/reportListModel.dart';

abstract class ReportListEvent{


}

class InitialReports extends ReportListEvent{}
class ReportLoader extends ReportListEvent{
  ReportList? data;

  ReportLoader(this.data);
}