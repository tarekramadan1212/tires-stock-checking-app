import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/presentation/ui/tires_stock_screen.dart';

import '../../core/app_cubit/app_cubit.dart';
import '../../core/app_cubit/app_states.dart';
import 'add_customer_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return AppBar(
              title: Text(appCubit.appBarTitles[appCubit.currentIndex]),
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
                icon: Icon(Icons.search, size: 29),
                label: 'Tires stock',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add_alt_sharp, size: 29),
                label: 'Waiting list',
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
    );
  }
}
