import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/presentation/ui/tires_stock_screen.dart';

import '../../core/app_cubit/app_cubit.dart';
import '../../core/app_cubit/app_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state){
          return BottomNavigationBar(
            onTap: (index)
            {
              appCubit.changeBottomNavItem(index);
            },
            currentIndex: appCubit.currentIndex,
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
      body: SafeArea(child: TiresStockScreen()),
    );
  }
}
