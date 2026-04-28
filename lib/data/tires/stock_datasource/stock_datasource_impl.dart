import 'package:dio/dio.dart';
import '../../../core/utilities/constants/strings.dart';
import '../stock_models/tires_model.dart';
import 'i_stock_datasource.dart';

class TiresDataImpl implements BaseTiresDataSource{

  final dio = Dio(
    BaseOptions(
      baseUrl: ConstantString.tiresBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
    )
  );

  @override
  Future<List<TireModel>>  searchTire({required String size}) async{
    final response = await dio.get('/tires', queryParameters: {'size': size});
    print('Response Data: ${response.data}');
    return (response.data as List).map((element) => TireModel.fromJson(element)).toList();
  }
}