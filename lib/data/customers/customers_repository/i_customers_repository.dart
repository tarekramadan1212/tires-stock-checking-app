import 'package:dartz/dartz.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class ICustomersRepo{
  Future<Either<CustomFailure, Unit>> addNewWaitingCustomer({required WaitingCustomerModel model});
  Future<Either<CustomFailure, List<WaitingCustomerModel>>> getAllWaitingCustomers();
  Future<Either<CustomFailure, Unit>> updateWaitingCustomer({required String customerId,required WaitingCustomerModel model});
  Future<Either<CustomFailure, Unit>> deleteWaitingCustomer({required String customerId});

}