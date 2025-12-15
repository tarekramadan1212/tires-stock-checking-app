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
                  Text('Quantity $quantity', style: theme.displayMedium),
                  Text(inStock?'In Stock':'Out of Stock', style: inStock?theme.displayMedium:theme.displayMedium!.copyWith(color: Colors.red)),
                ],
              ),
              Row(
                children: [
                  Text('Cost: $cost', style: theme.titleMedium),
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
