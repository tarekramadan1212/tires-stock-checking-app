import 'package:supreme/data/tires/stock_models/tires_model.dart';

enum CubitStatus { initial, loading, success, error }

class StockState {
  final List<TireModel> tires;
  final String message;
  final CubitStatus getTiresStatus;

  StockState({
    this.tires = const [],
    this.message = '',
    this.getTiresStatus = CubitStatus.initial,
  });

  StockState copyWith({
    List<TireModel>? tires,
    String? message,
    CubitStatus? getTiresStatus,
  }) {
    return StockState(
      tires: tires ?? this.tires,
      message: message ?? this.message,
      getTiresStatus: getTiresStatus ?? this.getTiresStatus,
    );
  }
}
