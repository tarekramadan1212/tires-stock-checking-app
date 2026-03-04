import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/demo_data.dart';

class TiresItemWidget extends StatelessWidget {
  const TiresItemWidget({
    required this.model, super.key,
  });

  final TireModel model;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.sizeAndBrand, style: theme.titleLarge),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: model.inStock ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      model.inStock ? '${model.quantity} In Stock' : 'Out of Stock',
                      style: model.inStock
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
                      Text(model.cost.toString(), style: theme.titleMedium),
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
