abstract class PaymentEvent {

}

class PaymentNumber extends PaymentEvent{
  final String? phoneNumber;
  PaymentNumber({this.phoneNumber});
}