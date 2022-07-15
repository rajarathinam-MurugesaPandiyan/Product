import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/Screen/Payment/paymentState.dart';
import 'package:product/Screen/Payment/paymentevent.dart';

class PaymentBloc extends Bloc<PaymentEvent ,PaymentState>{

  PaymentBloc(super.initialState){
    on<PaymentEvent>((event , emit){
      if(event is PaymentNumber){
        emit(PaymentState(event.phoneNumber));
      }
    });
  }
}



