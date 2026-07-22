import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

enum BlocStates { initial, loading, success, error }

class WaitingCustomerState {
  final List<WaitingCustomerModel> waitingCustomers;
  final BlocStates getCustomersState;
  final BlocStates addCustomerState;
  final BlocStates updateCustomerState;
  final BlocStates deleteCustomerState;
  final BlocStates changeCustomerStatusState;
  final BlocStates addPriceState;
  final String? errorMessage;
  final bool isSelectionMode;
  final List<int> selectedCustomers;
  final String? customerStatus;
  final String searchQuery;
  final BlocStates addNewBrandState;
  final BlocStates getSavedBrandsState;
  final List<String> savedSelectableBrands;
  final BlocStates sendWhatsAppMessageState;


  WaitingCustomerState({
    this.waitingCustomers = const [],
    this.addCustomerState = BlocStates.initial,
    this.updateCustomerState = BlocStates.initial,
    this.deleteCustomerState = BlocStates.initial,
    this.getCustomersState = BlocStates.initial,
    this.changeCustomerStatusState = BlocStates.initial,
    this.addPriceState = BlocStates.initial,
    this.errorMessage,
    this.isSelectionMode = false,
    this.selectedCustomers = const [],
    this.customerStatus,
    this.searchQuery = '',
    this.addNewBrandState = BlocStates.initial,
    this.getSavedBrandsState = BlocStates.initial,
    this.savedSelectableBrands = const[],
    this.sendWhatsAppMessageState = BlocStates.initial,
  });

  List<WaitingCustomerModel> get filteredCustomers
  {
    if(searchQuery.isEmpty) return waitingCustomers;
    return waitingCustomers.where((customer){
      final name = customer.customerName.toLowerCase();
      final size = customer.tireSize.toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || size.contains(query);
    }).toList();
  }

  WaitingCustomerState copyWith({
    List<WaitingCustomerModel>? waitingCustomers,
    BlocStates? addCustomerState,
    BlocStates? updateCustomerState,
    BlocStates? deleteCustomerState,
    BlocStates? getCustomersState,
    BlocStates? addPriceState,
    String? errorMessage,
    bool? isSelectionMode,
    List<int>? selectedCustomers,
    BlocStates? changeCustomerStatusState,
    String? customerStatus,
    String? searchQuery,
    BlocStates? addNewBrandState,
    BlocStates? getSavedBrandsState,
    List<String>? savedSelectableBrands,
    BlocStates? sendWhatsAppMessageState,
  }) {
    return WaitingCustomerState(
      waitingCustomers: waitingCustomers??this.waitingCustomers,
      addCustomerState: addCustomerState??this.addCustomerState,
      updateCustomerState: updateCustomerState??this.updateCustomerState,
      deleteCustomerState: deleteCustomerState??this.deleteCustomerState,
      getCustomersState: getCustomersState?? this.getCustomersState,
      addPriceState: addPriceState??this.addPriceState,
      errorMessage: errorMessage??this.errorMessage,
      isSelectionMode: isSelectionMode??this.isSelectionMode,
      selectedCustomers: selectedCustomers??this.selectedCustomers,
      changeCustomerStatusState: changeCustomerStatusState??this.changeCustomerStatusState,
      customerStatus: customerStatus??this.customerStatus,
      searchQuery: searchQuery??this.searchQuery,
      addNewBrandState: addNewBrandState??this.addNewBrandState,
      getSavedBrandsState: getSavedBrandsState?? this.getSavedBrandsState,
        savedSelectableBrands: savedSelectableBrands?? this.savedSelectableBrands,
      sendWhatsAppMessageState: sendWhatsAppMessageState??this.sendWhatsAppMessageState,
    );
  }
}
