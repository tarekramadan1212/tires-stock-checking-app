import 'package:flutter/cupertino.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';
import '../widgets/custom_waiting_list_item.dart';


class TireModel {
  final String sizeAndBrand;
  final int quantity;
  final double cost;
  final bool inStock;
  TireModel({
    required this.sizeAndBrand,
    required this.quantity,
    required this.cost,
    required this.inStock});
}

List<TireModel> tires = [
  TireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
  TireModel(sizeAndBrand: '215/55/17 KINFOREST', quantity: 120, cost: 100, inStock: false),
  TireModel(sizeAndBrand: '225/65/17 GOODYEAR', quantity: 120, cost: 180, inStock: true),
  TireModel(sizeAndBrand: '265/50/20 YOKOHAMA', quantity: 10, cost: 100, inStock: true),
  TireModel(sizeAndBrand: '265/70/17 TOYO', quantity: 120, cost: 100, inStock: false),
  TireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
  TireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
];

