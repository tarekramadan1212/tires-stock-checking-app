import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/customers/customers_datasource/I_customers_datasource.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import 'package:supreme/data/customers/customers_repository/i_customers_repository.dart';

class CustomersRepositoryImpl implements ICustomersRepo{

  final ICustomersDatasource datasource;
  CustomersRepositoryImpl({required this.datasource});
  @override
  Future<Either<CustomFailure, Unit>> addNewWaitingCustomer({required WaitingCustomerModel model}) async{
    try{
      await datasource.addNewWaitingCustomer(waitingCustomerModel: model);
      return const Right(unit);
    }on PostgrestException catch(e)
    {
      return Left(ServerFailure(e.message));
    }
    on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> deleteWaitingCustomer({required String customerId}) async{
    try{
      await datasource.deleteWaitingCustomer(customerId: customerId);
      return const Right(unit);
    } on PostgrestException catch(e)
    {
      return Left(ServerFailure(e.message));
    }on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }on SocketException catch (e)
    {
      return Left(NetworkFailure(e.message));
    }catch(e)
    {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, List<WaitingCustomerModel>>> getAllWaitingCustomers() async{
    try{
      final response = await datasource.getAllWaitingCustomers();
      return Right(response);
    }on PostgrestException catch(e)
    {
      return Left(ServerFailure(e.message));
    }on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }on SocketException catch (e)
    {
      return Left(NetworkFailure(e.message));
    }catch(e)
    {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> updateWaitingCustomer({required WaitingCustomerModel model})async {
    try{
      await datasource.updateWaitingCustomerStatus(waitingCustomerModel: model);
      return const Right(unit);
    }on PostgrestException catch(e)
    {
      return Left(ServerFailure(e.message));
    }on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }on SocketException catch (e)
    {
      return Left(NetworkFailure(e.message));
    }catch(e)
    {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

}