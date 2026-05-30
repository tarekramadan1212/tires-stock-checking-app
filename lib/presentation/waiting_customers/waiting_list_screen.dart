import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import '../../core/utilities/constants/app_colors.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_waiting_list_item.dart';

class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Search Customer Name',
            onChanged: (value) {
              context.read<WaitingListCubit>().searchCustomers(value);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<WaitingListCubit, WaitingCustomerState>(
              builder: (context, state) {
                final customers = state.filteredCustomers;
                if (customers.isEmpty && state.searchQuery.isNotEmpty) {
                  return const Center(
                    child: Text("No customers match your search."),
                  );
                }

                if (state.getCustomersState == BlocStates.loading || state.deleteCustomerState == BlocStates.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.getCustomersState == BlocStates.error) {
                  return Center(child: Text(state.errorMessage!));
                } else {
                  return state.waitingCustomers.isEmpty?
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.people_outline_rounded,
                                size: 64,
                                color: AppColors.primarySeed.withValues(alpha: 1),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Bold, clear headline
                            Text(
                              "No customers yet",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Helpful supporting subtitle
                            Text(
                              "When you add customers, they will appear here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) :
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomWaitingListItem(
                        customerModel: customers[index],
                      );
                    },
                    itemCount: customers.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
