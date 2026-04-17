import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class ICustomersDatasource {
  Future<WaitingCustomerModel> addNewWaitingCustomer({
    required WaitingCustomerModel waitingCustomerModel,
  });

  Future<List<WaitingCustomerModel>> getAllWaitingCustomers();

  Future<WaitingCustomerModel> updateWaitingCustomerData({
    required WaitingCustomerModel originalModel,
    required WaitingCustomerModel updatedModel,
  });

  Future<WaitingCustomerModel> deleteWaitingCustomer({required int customerId});

  Future<List<WaitingCustomerModel>>deleteSeveralWaitingCustomers(
      {required List<int> selectedCustomersIds});

  Future<String> changeCustomerStatus({required String status, required int id});
  //TODO: Search Method for customers.
}
