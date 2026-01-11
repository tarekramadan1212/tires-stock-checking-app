import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';

class WaitingListCubit extends Cubit<WaitingListStates>
{
  WaitingListCubit() : super(WaitingListInitialState());

  WaitingCustomerStatus customerStatus = PendingStatus();
  void changeCustomerStatus({required WaitingCustomerStatus newStatus})
  {
    customerStatus = newStatus;
    emit(ChangeCustomerStatusState());

  }



}