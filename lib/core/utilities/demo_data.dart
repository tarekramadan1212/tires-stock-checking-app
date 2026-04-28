

class MockTireModel {
  final String sizeAndBrand;
  final int quantity;
  final double cost;
  final bool inStock;
  MockTireModel({
    required this.sizeAndBrand,
    required this.quantity,
    required this.cost,
    required this.inStock});
}

List<MockTireModel> tires = [
  MockTireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
  MockTireModel(sizeAndBrand: '215/55/17 KINFOREST', quantity: 120, cost: 100, inStock: false),
  MockTireModel(sizeAndBrand: '225/65/17 GOODYEAR', quantity: 120, cost: 180, inStock: true),
  MockTireModel(sizeAndBrand: '265/50/20 YOKOHAMA', quantity: 10, cost: 100, inStock: true),
  MockTireModel(sizeAndBrand: '265/70/17 TOYO', quantity: 120, cost: 100, inStock: false),
  MockTireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
  MockTireModel(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
];

