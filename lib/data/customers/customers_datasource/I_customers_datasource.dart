
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class ICustomersDatasource{
  Future<void> addNewWaitingCustomer({required WaitingCustomerModel waitingCustomerModel});
  Future<List<WaitingCustomerModel>> getAllWaitingCustomers();
  Future<void> updateWaitingCustomerStatus({required WaitingCustomerModel waitingCustomerModel});
  Future<void> deleteWaitingCustomer({required String customerId});
  //TODO: Search Method for customers.
}

