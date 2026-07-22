import 'package:dartz/dartz.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class ICustomersServicesRepository {
  Future<Either<CustomFailure, Unit>> sendMessages({
    required WaitingCustomerModel customerModel,
    required String message,
  });
}
