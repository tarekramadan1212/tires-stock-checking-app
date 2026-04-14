import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import 'package:supreme/data/customers/customers_repository/i_customers_repository.dart';
import '../../core/widgets/custom_waiting_list_item.dart';

class WaitingListCubit extends Cubit<WaitingCustomerState> {
  final ICustomersRepo repository;

  WaitingListCubit({required this.repository}) : super(WaitingCustomerState());

  WaitingCustomerStatus customerStatus = WaitingCustomerStatus.pending;

  void changeCustomerStatus({required WaitingCustomerStatus newStatus}) {
    customerStatus = newStatus;
    //emit(ChangeCustomerStatusState());
  }

  Future<void> getWaitingCustomers() async {
    emit(state.copyWith(getCustomersState: BlocStates.loading));
    final result = await repository.getAllWaitingCustomers();
    result.fold(
          (failure) =>
          emit(
            state.copyWith(
              getCustomersState: BlocStates.error,
              errorMessage: failure.message,
            ),
          ),
          (customers) =>
          emit(
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
          (failure) =>
          emit(
            state.copyWith(
              addCustomerState: BlocStates.error,
              errorMessage: failure.message,
            ),
          ),
          (data) {
        state.waitingCustomers.add(data);
        emit(
          state.copyWith(
            waitingCustomers: state.waitingCustomers,
            addCustomerState: BlocStates.success,
          ),
        );
      },
    );
  }

  Future<void> updateCustomerData(
      {required WaitingCustomerModel originalModel, required WaitingCustomerModel updatedModel}) async
  {
    emit(state.copyWith(updateCustomerState: BlocStates.loading));
    final result = await repository.updateWaitingCustomer(
        originalModel: originalModel, updatedModel: updatedModel);
    result.fold(
            (failure) =>
            emit(
              state.copyWith(
                updateCustomerState: BlocStates.error,
                errorMessage: failure.message,
              ),
            ),
            (data) {
          final index = state.waitingCustomers.indexWhere((row) =>
          row.id == data.id);
          final List<WaitingCustomerModel> newList = List.from(
              state.waitingCustomers);
          newList[index] = data;
          emit(state.copyWith(waitingCustomers: newList,
              updateCustomerState: BlocStates.success));
        });
  }

  Future<void> deleteCustomer({required String customerId}) async {
    emit(state.copyWith(deleteCustomerState: BlocStates.loading));
    final result = await repository.deleteWaitingCustomer(
        customerId: customerId);
    result.fold((failure) =>
        emit(state.copyWith(
        deleteCustomerState: BlocStates.error,
        errorMessage: failure.message)), (data){
      state.waitingCustomers.remove(data);
      emit(state.copyWith(
        waitingCustomers: state.waitingCustomers,
        deleteCustomerState: BlocStates.success,
      ));
    });
  }

  bool isSelectionMode = false;
  void toggleSelectionMode() {
    isSelectionMode = !isSelectionMode;
    emit(state.copyWith(isSelectionMode: isSelectionMode));
  }


}
