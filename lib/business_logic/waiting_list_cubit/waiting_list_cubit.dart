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
    if (state.waitingCustomers.isNotEmpty) return;
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

  Future<void> updateCustomerData({
    required WaitingCustomerModel originalModel,
    required WaitingCustomerModel updatedModel,
  }) async {
    emit(state.copyWith(updateCustomerState: BlocStates.loading));
    final result = await repository.updateWaitingCustomer(
      originalModel: originalModel,
      updatedModel: updatedModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          updateCustomerState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (data) {
        final index = state.waitingCustomers.indexWhere(
          (row) => row.id == data.id,
        );
        final List<WaitingCustomerModel> newList = List.from(
          state.waitingCustomers,
        );
        newList[index] = data;
        emit(
          state.copyWith(
            waitingCustomers: newList,
            updateCustomerState: BlocStates.success,
          ),
        );
      },
    );
  }

  Future<void> deleteSingleCustomer() async {
    emit(state.copyWith(deleteCustomerState: BlocStates.loading));
    final result = await repository.deleteWaitingCustomer(
      customerId: state.selectedCustomers[0],
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteCustomerState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            waitingCustomers: state.waitingCustomers
                .where((element) => element.id != data.id)
                .toList(),
            deleteCustomerState: BlocStates.success,
          ),
        );
      },
    );
  }

  Future<void> deleteSeveralCustomers() async {
    emit(state.copyWith(deleteCustomerState: BlocStates.loading));
    final result = await repository.deleteSeveralWaitingCustomers(
      selectedCustomersIds: state.selectedCustomers,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteCustomerState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (data) {
        final deletedIds = data.map((customer) => customer.id).toSet();
        final newList = state.waitingCustomers
            .where((customer) => !deletedIds.contains(customer.id))
            .toList();
        emit(
          state.copyWith(
            waitingCustomers: newList,
            deleteCustomerState: BlocStates.success,
          ),
        );
      },
    );
  }

  void toggleSelectionMode() {
    final newMode = !state.isSelectionMode;
    emit(
      state.copyWith(
        isSelectionMode: newMode,
        selectedCustomers: newMode ? state.selectedCustomers : [],
      ),
    );
  }

  void selectItem({required int id}) {
    if (state.selectedCustomers.contains(id)) {
      emit(
        state.copyWith(
          selectedCustomers: state.selectedCustomers
              .where((element) => element != id)
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(selectedCustomers: [...state.selectedCustomers, id]));
    }
  }

  Future<void> changeCustomerStatusData({
    required preStatus,
    required String status,
    required int id,
  }) async {
    String prevStatus = preStatus;
    emit(
      state.copyWith(
        changeCustomerStatusState: BlocStates.loading,
        customerStatus: status,
      ),
    );
    final result = await repository.changeCustomerStatus(
      status: status,
      id: id,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          customerStatus: prevStatus,
          changeCustomerStatusState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (newStatus) {
        List<WaitingCustomerModel> newList = List.from(state.waitingCustomers);
        final index = newList.indexWhere((element) => element.id == id);
        newList[index] = newList[index].copyWith(status: newStatus);
        emit(
          state.copyWith(
            waitingCustomers: newList,
            customerStatus: newStatus,
            changeCustomerStatusState: BlocStates.success,
          ),
        );
      },
    );
  }

  Future<void> addPrice({required int id, required List<double> prices}) async {
    emit(state.copyWith(addPriceState: BlocStates.loading));
    final oldSet = state.waitingCustomers
        .firstWhere((element) => element.id == id)
        .prices
        .toSet();
    final newSet = prices.toSet();
    final newPrices = newSet.difference(oldSet);
    if (newPrices.isEmpty) {
      emit(
        state.copyWith(
          addPriceState: BlocStates.error,
          errorMessage: 'Trying to add same price again, No new prices to add',
        ),
      );
      return;
    }
    final result = await repository.addPrices(id: id, prices: prices);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addPriceState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (prices) {
        List<WaitingCustomerModel> newList = List.from(state.waitingCustomers);
        final index = newList.indexWhere((element) => element.id == id);
        newList[index] = newList[index].copyWith(prices: prices);
        emit(
          state.copyWith(
            waitingCustomers: newList,
            addPriceState: BlocStates.success,
          ),
        );
      },
    );
  }

  void searchCustomers(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void addNewBrand({required List<String> brands, required String key}) async {
    emit(state.copyWith(addNewBrandState: BlocStates.loading));
    final result = await repository.addNewBrand(key: key, brands: brands);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addNewBrandState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (unit) async {
        emit(state.copyWith(addNewBrandState: BlocStates.success));
        getSavedBrands(key: key);
      },
    );
  }

  void getSavedBrands({required String key}) async {
    emit(state);
    emit(state.copyWith(getSavedBrandsState: BlocStates.loading));
    final savedBrands = await repository.getSavedBrands(key: key);
    savedBrands.fold(
      (failure) => emit(
        state.copyWith(
          getSavedBrandsState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (brands) {
        emit(
          state.copyWith(
            getSavedBrandsState: BlocStates.success,
            savedSelectableBrands: brands,
          ),
        );
      },
    );
  }

  void sendWhatsAppMessage({
    required WaitingCustomerModel customerModel,
  }) async {
    if (customerModel.prices.isEmpty) {
      emit(
        state.copyWith(
          sendWhatsAppMessageState: BlocStates.error,
          errorMessage: "Cannot send message: No prices added yet.",
        ),
      );
      return;
    }
    emit(state.copyWith(sendWhatsAppMessageState: BlocStates.loading));
    final price = customerModel.prices.first;
    String priceAndBrand = '';
    String priceAndBrandArabic = '';
    for(int i = 0; i<customerModel.prices.length; i++)
      {
        if(customerModel.prices[i] == 0)
          {
            priceAndBrand += '${customerModel.tireBrand[i]} - *Stock Out* \n';
            priceAndBrandArabic += '${customerModel.tireBrand[i]} - *غير متوفر* \n';

          }else
            {
              priceAndBrand += '${customerModel.tireBrand[i]} - *Price:* ${customerModel.prices[i]} \n';
              priceAndBrandArabic += '${customerModel.tireBrand[i]} - *السعر:* ${customerModel.prices[i]} \n';

            }
      }
    final result = await repository.sendMessages(
      customerModel: customerModel,
      message:
          "Hello ${customerModel.customerName}! 👋\n\n"
          "Here are the details for the tires you requested:\n"
          "• *Size:* ${customerModel.tireSize}\n"
          "• *Brand:* $priceAndBrand\n"
          "any questions?"
          "\n\n"
          "مرحباً ${customerModel.customerName}! 👋\n\n"
          "إليك تفاصيل الإطارات التي طلبتها:\n"
          "• المقاس: ${customerModel.tireSize}\n"
          "• العلامة التجارية: $priceAndBrandArabic\n"
          "هل لديك أي أسئلة؟",
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          sendWhatsAppMessageState: BlocStates.error,
          errorMessage: failure.message,
        ),
      ),
      (unit) =>
          emit(state.copyWith(sendWhatsAppMessageState: BlocStates.success)),
    );
  }
}
