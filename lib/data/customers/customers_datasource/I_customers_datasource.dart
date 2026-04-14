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

  Future<WaitingCustomerModel> deleteWaitingCustomer({required String customerId});
  //TODO: Search Method for customers.
}
