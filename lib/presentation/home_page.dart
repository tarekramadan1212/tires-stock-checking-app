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
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return BlocBuilder<WaitingListCubit, WaitingCustomerState>(
                builder: (context, state) {
                  return AppBar(
                    title: Text(appCubit.appBarTitles[appCubit.currentIndex]),
                    leading: state.isSelectionMode
                        ? IconButton(
                            onPressed: () {
                              waitingListCubit.toggleSelectionMode();
                            },
                            icon: Icon(Icons.arrow_back_rounded),
                          )
                        : null,
                    actions: [
                      ?state.selectedCustomers.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                if (state.selectedCustomers.length == 1) {
                                  waitingListCubit.deleteSingleCustomer();
                                } else {
                                  waitingListCubit.deleteSeveralCustomers();
                                }
                                waitingListCubit.toggleSelectionMode();
                              },
                              icon: Icon(Icons.delete),
                            )
                          : null,
                    ],
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            // Extracting colors to keep the layout clean
            final theme = Theme.of(context);

            return Container(
              // Gives it a modern floating card look
              padding: EdgeInsets.symmetric(vertical: 11),
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent
                  ),
                  child: BottomNavigationBar(
                    onTap: (index) => appCubit.changeBottomNavItem(index),
                    currentIndex: appCubit.currentIndex,
                    elevation: 0,
                    // Handled by container shadow
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: theme.colorScheme.primary,
                    unselectedItemColor: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.6),
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    showUnselectedLabels: true,

                    items: const [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(Icons.dashboard_outlined, size: 24),
                        ),
                        activeIcon: Icon(Icons.dashboard, size: 24),
                        label: 'Tires Stock',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(Icons.groups_outlined, size: 24),
                        ),
                        activeIcon: Icon(Icons.groups, size: 24),
                        label: 'Waiting List',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(Icons.account_circle_outlined, size: 24),
                        ),
                        activeIcon: Icon(Icons.account_circle, size: 24),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
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
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: Container(
                  key: ValueKey<int>(appCubit.currentIndex),
                  child: appCubit.screens[appCubit.currentIndex],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
