import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String? image;
  final String? issueName;
  final String? orderId;
  final String? description;

  Report({
    this.image,
    this.description,
    this.issueName,
    this.orderId
  });


  @override
  // TODO: implement props
  List<Object?> get props => [image];

}