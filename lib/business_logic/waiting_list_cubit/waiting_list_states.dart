import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

enum BlocStates { initial, loading, success, error }

class WaitingCustomerState {
  final List<WaitingCustomerModel> waitingCustomers;
  final BlocStates getCustomersState;
  final BlocStates addCustomerState;
  final BlocStates updateCustomerState;
  final BlocStates deleteCustomerState;
  final String? errorMessage;
  final bool isSelectionMode;
  final List<int> selectedCustomers;


  WaitingCustomerState({
    this.waitingCustomers = const [],
    this.addCustomerState = BlocStates.initial,
    this.updateCustomerState = BlocStates.initial,
    this.deleteCustomerState = BlocStates.initial,
    this.getCustomersState = BlocStates.initial,
    this.errorMessage,
    this.isSelectionMode = false,
    this.selectedCustomers = const []
  });

  WaitingCustomerState copyWith({
    List<WaitingCustomerModel>? waitingCustomers,
    BlocStates? addCustomerState,
    BlocStates? updateCustomerState,
    BlocStates? deleteCustomerState,
    BlocStates? getCustomersState,
    String? errorMessage,
    bool? isSelectionMode,
    List<int>? selectedCustomers
  }) {
    return WaitingCustomerState(
      waitingCustomers: waitingCustomers??this.waitingCustomers,
      addCustomerState: addCustomerState??this.addCustomerState,
      updateCustomerState: updateCustomerState??this.updateCustomerState,
      deleteCustomerState: deleteCustomerState??this.deleteCustomerState,
      getCustomersState: getCustomersState?? this.getCustomersState,
      errorMessage: errorMessage??this.errorMessage,
      isSelectionMode: isSelectionMode??this.isSelectionMode,
      selectedCustomers: selectedCustomers??this.selectedCustomers,
    );
  }
}
