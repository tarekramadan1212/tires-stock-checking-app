import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import '../../data/tires/stock_models/tires_model.dart';
import '../../presentation/search_stock/transaction_history_screen.dart';

class TiresItemWidget extends StatelessWidget {
  const TiresItemWidget({required this.model, super.key});

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
              Expanded(
                flex: 2,
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.size} ${model.brand}',
                      style: theme.titleLarge,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.2),
                          decoration: BoxDecoration(
                            color: model.quantity > 0?AppColors.success.withValues(alpha: 0.8):AppColors.warning.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            model.quantity > 0
                                ? '${model.quantity} In Stock'
                                : 'Out of Stock',
                            style: model.quantity > 0
                                ? theme.displayMedium!.copyWith(color: Colors.white)
                                : theme.displayMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${model.price.toString()} BD',
                            style: theme.displayMedium!.copyWith(color: Colors.white)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 75, minHeight: 62),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TransactionHistoryScreen(tire: model,)));
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded))

            ],
          ),
        ),
      ),
    );
  }
}
