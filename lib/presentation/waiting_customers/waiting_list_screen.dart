import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import '../../core/services/service_locator.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_waiting_list_item.dart';

class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return sl<WaitingListCubit>()..getWaitingCustomers();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            CustomTextField(hintText: 'Search Customer Name'),
            const SizedBox(height: 10,),
            Expanded(
              child: BlocConsumer<WaitingListCubit, WaitingCustomerState>(
                listener: (context, state){
                  if(state.getCustomersState == BlocStates.success)
                    {
                      print('success');
                      print('DATA : ${state.waitingCustomers[0].id}');
                    }
                  else if(state.getCustomersState == BlocStates.error)
                    {
                      print('Error -- ${state.errorMessage}');
                    }
                  else if(state.getCustomersState == BlocStates.loading)
                    {
                      print('loading');
                    }
                },
                builder: (context, state) {
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
                        return CustomWaitingListItem(customerModel: state.waitingCustomers[index]);
                      },
                        itemCount: state.waitingCustomers.length,
                      );
                    }

                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
