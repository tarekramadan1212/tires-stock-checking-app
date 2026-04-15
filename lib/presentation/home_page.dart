import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import '../core/app_cubit/app_cubit.dart';
import '../core/app_cubit/app_states.dart';
import '../core/services/service_locator.dart';
import 'waiting_customers/add_customer_screen.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
   final WaitingListCubit waitingListCubit = sl<WaitingListCubit>();

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    return BlocProvider.value(
      value: waitingListCubit..getWaitingCustomers(),
        child:  Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return BlocBuilder<WaitingListCubit, WaitingCustomerState>(
                  builder: (context, state) {
                    return AppBar(
                      title: Text(appCubit.appBarTitles[appCubit.currentIndex]),
                      leading: state.isSelectionMode?IconButton(
                        onPressed: ()
                        {
                          waitingListCubit.toggleSelectionMode();
                        },
                        icon: Icon(Icons.arrow_back_rounded),
                      ) : null,
                      actions: [
                        ?state.selectedCustomers.isNotEmpty?IconButton(
                            onPressed: ()
                            {
                              if(state.selectedCustomers.length == 1)
                                {
                                  waitingListCubit.deleteSingleCustomer();
                                }
                              else
                                {
                                  waitingListCubit.deleteSeveralCustomers();
                                }
                              waitingListCubit.toggleSelectionMode();
                            },
                            icon: Icon(Icons.delete),
                        ): null
                      ],
                    );
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return BottomNavigationBar(
                onTap: (index) {
                  appCubit.changeBottomNavItem(index);
                },
                currentIndex: appCubit.currentIndex,
                elevation: 4.5,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined, size: 29),
                    label: 'Tires stock',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.groups_outlined, size: 29),
                    label: 'Waiting list',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined, size: 29),
                    label: 'Profile',
                  ),
                ],
              );
            },
          ),
          floatingActionButton: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return appCubit.currentIndex == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCustomerScreen(),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    )
                  : SizedBox.shrink();
            },
          ),

          body: SafeArea(
            child: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return appCubit.screens[appCubit.currentIndex];
              },
            ),
          ),
        ),
    );
  }
}
