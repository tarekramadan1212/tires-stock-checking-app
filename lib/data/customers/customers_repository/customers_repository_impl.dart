import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/customers/customers_datasource/I_customers_datasource.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import 'package:supreme/data/customers/customers_repository/i_customers_repository.dart';

class CustomersRepositoryImpl implements ICustomersRepo {
  final ICustomersDatasource datasource;

  CustomersRepositoryImpl({required this.datasource});

  Future<Either<CustomFailure, T>> _repoHandler<T>(
    Future<T> Function() action,
  ) async {
    try {
      final result = await action();
      return Right(result);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, WaitingCustomerModel>> addNewWaitingCustomer({
    required WaitingCustomerModel model,
  }) async {
    return _repoHandler(() async {
      return await datasource.addNewWaitingCustomer(
        waitingCustomerModel: model,
      );
    });
  }

  ///in the prev method when i called the _repoHandler i didn't explicitly declare the generic type <T>
  ///cause dart can infer it from the returned data from that method. so when we apply this to the prev
  ///method example the T now is Unit, Dart just inferred it from the returned data,

  @override
  Future<Either<CustomFailure, Unit>> deleteWaitingCustomer({
    required String customerId,
  }) async {
    return _repoHandler(() async {
      await datasource.deleteWaitingCustomer(customerId: customerId);
      return unit;
    });
  }

  @override
  Future<Either<CustomFailure, List<WaitingCustomerModel>>>
  getAllWaitingCustomers() async {
    return _repoHandler(() async {
      return await datasource.getAllWaitingCustomers();
    });
  }

  @override
  Future<Either<CustomFailure, WaitingCustomerModel>> updateWaitingCustomer({
    required WaitingCustomerModel originalModel,
    required WaitingCustomerModel updatedModel,
  }) async {
    return _repoHandler(() async {
      return await datasource.updateWaitingCustomerData(
        originalModel: originalModel,
        updatedModel: updatedModel,
      );
    });
  }
}
