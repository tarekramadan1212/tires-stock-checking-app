import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import '../../data/tires/stock_models/tires_model.dart';

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
                            color: Colors.deepOrangeAccent.withValues(alpha: 0.8),
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

              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded))

              ///The Price section
              // Expanded(
              //   flex: 1,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Expanded(
              //         flex: 2,
              //         child: Container(
              //           padding: const EdgeInsets.all(1.2),
              //           decoration: BoxDecoration(
              //             color: Colors.grey.shade200,
              //             borderRadius: BorderRadius.circular(5),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text('Cost', style: theme.titleMedium),
              //               Text(
              //                 model.quantity.toString(),
              //                 style: theme.titleMedium,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       //SizedBox(width: 2.0),
              //       IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded))
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
