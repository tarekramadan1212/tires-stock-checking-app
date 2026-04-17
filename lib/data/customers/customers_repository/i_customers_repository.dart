import 'package:dartz/dartz.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class ICustomersRepo {
  Future<Either<CustomFailure, WaitingCustomerModel>> addNewWaitingCustomer({
    required WaitingCustomerModel model,
  });

  Future<Either<CustomFailure, List<WaitingCustomerModel>>>
  getAllWaitingCustomers();

  Future<Either<CustomFailure, WaitingCustomerModel>> updateWaitingCustomer({
    required WaitingCustomerModel originalModel,
    required WaitingCustomerModel updatedModel,
  });

  Future<Either<CustomFailure, WaitingCustomerModel>> deleteWaitingCustomer({
    required int customerId,
  });

  Future<Either<CustomFailure, List<WaitingCustomerModel>>>
  deleteSeveralWaitingCustomers({required List<int> selectedCustomersIds});

  Future<Either<CustomFailure, String>> changeCustomerStatus({required String status, required int id});

}
