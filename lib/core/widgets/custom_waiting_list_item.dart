import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import 'package:supreme/presentation/waiting_customers/add_customer_screen.dart';
import '../../data/customers/customers_models/waiting_customer_model.dart';

class CustomWaitingListItem extends StatelessWidget {
  const CustomWaitingListItem({required this.customerModel, super.key});

  final WaitingCustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddCustomerScreen(customer: customerModel),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 5.6,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.primarySeed.withValues(
                          alpha: 0.5,
                        ),
                        child: Text(customerModel.customerName[0]),
                      ),
                      Flexible(
                        child: Column(
                          spacing: 3,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customerModel.customerName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.titleMedium,
                            ),
                            Text(
                              customerModel.tireSize,
                              style: theme.displayMedium,
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Icon(Icons.phone, size: 16),
                                Text(
                                  customerModel.phoneNumber,
                                  style: theme.displaySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 2.0,),

                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.1,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySeed.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<WaitingCustomerStatus>(
                    value: WaitingCustomerStatus.pending,
                    underline: Container(),
                    items: WaitingCustomerStatus.values.map((
                      WaitingCustomerStatus status,
                    ) {
                      return DropdownMenuItem<WaitingCustomerStatus>(
                        value: status,
                        child: Text(
                          status.label,
                          style: theme.displayMedium!.copyWith(
                            color: status.color,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (WaitingCustomerStatus? newValue) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum WaitingCustomerStatus {
  pending('Pending', Colors.orange),
  notified('Notified', Colors.green),
  cancelled('Cancelled', Colors.red),
  completed('Completed', Colors.blue);

  final String label;
  final Color color;

  const WaitingCustomerStatus(this.label, this.color);
}
