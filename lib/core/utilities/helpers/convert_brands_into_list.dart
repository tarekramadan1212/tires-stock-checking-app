List<String> convertTiresBrandsIntoList({required String tireBrands}) {
  if (tireBrands.isEmpty) return [];
  List<String> brands = [];
  String brand = '';
  for (int i = 0; i < tireBrands.length; i++) {
    if (tireBrands[i] == ',') {
      brands.add(brand.trim());
      brand = '';
    } else {
      brand += tireBrands[i];
    }
  }
  if(brands.isEmpty && brand.isNotEmpty) brands.add(brand.trim());
  return brands;
}
