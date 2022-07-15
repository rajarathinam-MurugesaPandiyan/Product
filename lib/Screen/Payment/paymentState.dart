import 'package:equatable/equatable.dart';


class PaymentState {

  final String? phoneNumber;

  const PaymentState(this.phoneNumber);

  @override
  List<Object> get props =>[phoneNumber??[]];

}

class PaymentLoad extends PaymentState {
  PaymentLoad(super.phoneNumber);


}