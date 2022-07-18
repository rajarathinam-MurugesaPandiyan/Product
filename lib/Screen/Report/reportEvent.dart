import 'dart:io';

abstract class ReportEvent {

}

class ReportSubmitEvent extends ReportEvent{
  final String? image;
  final String? description;
  final String? issueTitle;
  final String? orderId;

  ReportSubmitEvent( {
    this.image, this.description, this.issueTitle , this.orderId
   });

}
