import 'package:flutter/material.dart';

class TiresItemWidget extends StatelessWidget {
  const TiresItemWidget({
    required this.sizeAndBrand,
    required this.cost,
    required this.quantity,
    required this.inStock,
    super.key,
  });

  final String sizeAndBrand;
  final double cost;
  final int quantity;
  final bool inStock;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sizeAndBrand, style: theme.titleLarge),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: inStock ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      inStock ? '$quantity In Stock' : 'Out of Stock',
                      style: inStock
                          ? theme.displayMedium!.copyWith(color: Colors.white)
                          : theme.displayMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              ///The Price section
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cost', style: theme.titleMedium),
                      Text(cost.toString(), style: theme.titleMedium),
                    ],
                  ),
                  SizedBox(width: 2.0,),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
