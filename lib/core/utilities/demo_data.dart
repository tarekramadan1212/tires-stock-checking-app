import 'package:flutter/cupertino.dart';
import 'package:supreme/core/widgets/tires_item_widget.dart';

List<Widget> stockItem =
    [
      TiresItemWidget(sizeAndBrand: '215/55/17 MICHELIN', quantity: 120, cost: 100, inStock: true),
      TiresItemWidget(sizeAndBrand: '265/65/17 KINFOREST', quantity: 120, cost: 80, inStock: true,),
      TiresItemWidget(sizeAndBrand: '265/70/17 KINFOREST', quantity: 0, cost: 88, inStock: false,),
      TiresItemWidget(sizeAndBrand: '195/65/15 YOKOHAMA', quantity: 54, cost: 40, inStock: true,),
      TiresItemWidget(sizeAndBrand: '225/65/17 GOODYEAR', quantity: 0,cost: 180, inStock: false,),
      TiresItemWidget(sizeAndBrand: '215/55/17 BRIDGESTONE', quantity: 25, cost: 170, inStock: true),
      TiresItemWidget(sizeAndBrand: '265/70/17 SUMITOMO', quantity: 4, cost: 190, inStock: true,),
    ];