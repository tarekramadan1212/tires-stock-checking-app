import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';

class CustomWaitingListItem extends StatelessWidget {
  const CustomWaitingListItem({
    required this.customerName,
    required this.phoneNumber,
    required this.tireSize,
    required this.tireBrand,
    required this.notes,
    required this.date,
    required this.customerStatus,
    super.key,
  });

  final String customerName;
  final String phoneNumber;
  final String tireSize;
  final String tireBrand;
  final String notes;
  final String date;
  final WaitingCustomerStatus customerStatus;

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
              Row(
                spacing: 5.6,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primarySeed.withValues(alpha: 0.5),
                    child: Text(customerName[0]),
                  ),
                  Column(
                    spacing: 3,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName,
                        style: theme.titleMedium!.copyWith(color: Colors.black),
                      ),
                      Text(tireSize, style: theme.displayMedium!.copyWith(color: Colors.grey.shade500)),
                      Row(
                        spacing: 2,
                        children: [
                          Icon(Icons.phone, size: 16,),
                          Text(phoneNumber, style: theme.displayMedium),
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
