import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';

import '../stock_datasource/i_stock_datasource.dart';
import '../stock_models/tires_model.dart';
import 'i_stock_repository.dart';

class TiresRepositoryImpl implements BaseTiresRepository{

  final BaseTiresDataSource dataSource;
  TiresRepositoryImpl({required this.dataSource});

  @override
  Future<Either<CustomFailure, List<TireModel>>> searchTire({required String size}) async{
    try{
      final tires = await dataSource.searchTire(size: size);
      return Right(tires);
    } on DioException catch(e)
    {
      return Left(ServerFailure(e.message ?? 'Something went wrong'));
    }
  }

}