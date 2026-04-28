import 'package:dartz/dartz.dart';
import '../../../core/utilities/netwrok/failures.dart';
import '../stock_models/tires_model.dart';

abstract class BaseTiresRepository{
  Future<Either<CustomFailure, List<TireModel>>> searchTire({required String size});
}