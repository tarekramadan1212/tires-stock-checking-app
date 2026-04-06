import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import 'package:supreme/data/customers/customers_repository/customers_repository_impl.dart';
import 'package:supreme/data/customers/customers_repository/i_customers_repository.dart';

class WaitingListCubit extends Cubit<WaitingCustomerState> {
  final ICustomersRepo repository;

  WaitingListCubit({required this.repository}) : super(WaitingCustomerState());

  WaitingCustomerStatus customerStatus = PendingStatus();

  void changeCustomerStatus({required WaitingCustomerStatus newStatus}) {
    customerStatus = newStatus;
    //emit(ChangeCustomerStatusState());
  }

  Future<void> getWaitingCustomers() async {
    emit(state.copyWith(getCustomersState: BlocStates.loading));
    final result = await repository.getAllWaitingCustomers();
    result.fold(
      (failure) => emit(
        state.copyWith(
          getCustomersState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (customers) => emit(
        state.copyWith(
          getCustomersState: BlocStates.success,
          waitingCustomers: customers,
        ),
      ),
    );
  }

  Future<void> addNewCustomer(WaitingCustomerModel model) async {
    emit(state.copyWith(addCustomerState: BlocStates.loading));
    final result = await repository.addNewWaitingCustomer(model: model);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addCustomerState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(addCustomerState: BlocStates.success)),
    );
  }
}
