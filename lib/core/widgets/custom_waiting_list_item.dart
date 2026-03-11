import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import 'package:supreme/presentation/waiting_list_screen.dart';

class CustomWaitingListItem extends StatelessWidget {
  const CustomWaitingListItem({
    required this.customerModel,
    super.key,
  });

  final WaitingCustomerModel customerModel;

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
              Row(
                spacing: 5.6,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primarySeed.withValues(alpha: 0.5),
                    child: Text(customerModel.customerName[0]),
                  ),
                  Column(
                    spacing: 3,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerModel.customerName,
                        style: theme.titleMedium,
                      ),
                      Text(customerModel.tireSize, style: theme.displayMedium),
                      Row(
                        spacing: 2,
                        children: [
                          Icon(Icons.phone, size: 16,),
                          Text(customerModel.phoneNumber, style: theme.displaySmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(vertical:2.1, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.primarySeed.withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<WaitingCustomerStatus>(
                  value: waitingCustomerStatus[3],
                  underline: Container(),
                  items: waitingCustomerStatus.map((WaitingCustomerStatus status) {
                    return DropdownMenuItem<WaitingCustomerStatus>(
                      value: status,
                      child: Text(status.label,style: theme.displayMedium!.copyWith(color: status.color),),
                    );
                  }).toList(),
                  onChanged: (WaitingCustomerStatus? newValue)
                  {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
