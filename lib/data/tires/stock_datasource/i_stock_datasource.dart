
import '../stock_models/tires_model.dart';

abstract class BaseTiresDataSource{

  Future<List<TireModel>> searchTire({required String size});
}