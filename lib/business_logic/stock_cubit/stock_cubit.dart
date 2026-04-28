import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/stock_cubit/stock_states.dart';
import 'package:supreme/data/tires/stock_repository/i_stock_repository.dart';

class StockCubit extends Cubit<StockState> {

  final BaseTiresRepository repository;
  StockCubit({required this.repository}) : super(StockState());
  
  Future<void> searchSize({required String size})async
  {
    emit(StockState(getTiresStatus: CubitStatus.loading));

    final result = await repository.searchTire(size: size);

    result.fold(
            (failure) {
              emit(StockState(getTiresStatus: CubitStatus.error, message: failure.message));
            },
            (tires){
              emit(StockState(tires: tires, getTiresStatus: CubitStatus.success));
            }
    );
  }
  
}