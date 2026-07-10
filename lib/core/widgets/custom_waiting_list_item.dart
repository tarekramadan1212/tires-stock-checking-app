import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import 'package:supreme/presentation/waiting_customers/add_customer_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import '../../business_logic/waiting_list_cubit/waiting_list_states.dart';
import '../../data/customers/customers_models/waiting_customer_model.dart';

class CustomWaitingListItem extends StatelessWidget {
  const CustomWaitingListItem({required this.customerModel, super.key});

  final WaitingCustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme
        .of(context)
        .textTheme;
    final cubit = context.read<WaitingListCubit>();
    return BlocBuilder<WaitingListCubit, WaitingCustomerState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.isSelectionMode) {
              cubit.selectItem(id: customerModel.id!);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddCustomerScreen(customer: customerModel),
                ),
              );
            }
          },
          onLongPress: () {
            cubit.toggleSelectionMode();
            cubit.selectItem(id: customerModel.id!);
          },
          child: SizedBox(
            width: double.infinity,
            child: Card(
              color: Theme
                  .of(context)
                  .colorScheme
                  .surface,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<WaitingListCubit, WaitingCustomerState>(
                  builder: (context, state) {
                    Widget? selectTrailingIcon() {
                      if (!state.isSelectionMode) return null;
                      final isSelected = state.selectedCustomers.contains(
                        customerModel.id,
                      );
                      return Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColors.primarySeed,
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(child: selectTrailingIcon()),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ROW 1: The Main Heroes (Name)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Boldest element
                                  Expanded(
                                    child: Text(
                                      customerModel.customerName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.titleMedium!.copyWith(
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6), // Clean breathing room
                              // ROW 2: The Secondary Details (tire size)
                              Row(
                                children: [
                                  Text(
                                    customerModel.tireSize,
                                    style: theme.titleMedium!.copyWith(
                                      color: AppColors.primarySeed,
                                      fontWeight: FontWeight.w800, // Pops out instantly
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.access_time_filled_rounded, size: 13, color: Colors.grey.shade400),
                                      const SizedBox(width: 4),
                                      Text(
                                        timeago.format(DateTime.parse(customerModel.createdAt)),
                                        style: theme.bodySmall!.copyWith(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              Text(
                                'Phone: ${customerModel.phoneNumber}',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        BlocBuilder<WaitingListCubit, WaitingCustomerState>(
                          builder: (context, state) {
                            final currentItem = state.waitingCustomers.firstWhere(
                                  (element) => element.id == customerModel.id,
                              orElse: () => customerModel,
                            );

                            final currentStatus = WaitingCustomerStatus.values.byName(currentItem.status!);

                            return PopupMenuButton<WaitingCustomerStatus>(
                              initialValue: currentStatus,
                              tooltip: 'Change Status',
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: currentStatus.color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20), // Makes it look like a pill chip
                                  border: Border.all(color: currentStatus.color.withValues(alpha: 0.5)),
                                ),
                                child: Text(
                                  currentStatus.label.toUpperCase(),
                                  style: theme.displayMedium!.copyWith(
                                    color: currentStatus.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // This builds the menu options when the chip is clicked
                              itemBuilder: (BuildContext context) {
                                return WaitingCustomerStatus.values.map((WaitingCustomerStatus status) {
                                  return PopupMenuItem<WaitingCustomerStatus>(
                                    value: status,
                                    child: Row(
                                      children: [
                                        CircleAvatar(radius: 6, backgroundColor: status.color),
                                        const SizedBox(width: 10),
                                        Text(
                                          status.label,
                                          style: theme.bodyMedium?.copyWith(
                                            fontWeight: status == currentStatus ? FontWeight.bold : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (WaitingCustomerStatus newValue) {
                                if (newValue.label != currentItem.status) {
                                  cubit.changeCustomerStatusData(
                                    preStatus: currentItem.status!,
                                    status: newValue.name,
                                    id: currentItem.id!,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum WaitingCustomerStatus {
  pending('pending', Colors.orange),
  notified('notified', Colors.green),
  cancelled('cancelled', Colors.red),
  completed('completed', Colors.blue);

  final String label;
  final Color color;

  const WaitingCustomerStatus(this.label, this.color);
}
