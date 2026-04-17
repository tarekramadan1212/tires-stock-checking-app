import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
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
            onChanged: (value)
            {
              context.read<WaitingListCubit>().searchCustomers(value);
            },
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: BlocBuilder<WaitingListCubit, WaitingCustomerState>(
              builder: (context, state) {
                final customers = state.filteredCustomers;

                if(customers.isEmpty && state.searchQuery.isNotEmpty) {
                  return const Center(child: Text("No customers match your search."));
                }

                if(state.getCustomersState == BlocStates.loading)
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                else if(state.getCustomersState == BlocStates.error)
                  {
                    return Center(child: Text(state.errorMessage!));
                  }
                else
                  {
                    return ListView.builder(itemBuilder: (context, index) {
                      return CustomWaitingListItem(customerModel: customers[index]);
                    },
                      itemCount: customers.length,
                    );
                  }

              }
            ),
          ),
        ],
      ),
    );
  }
}
