import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/core/app_cubit/app_states.dart';
import 'package:supreme/presentation/tires_stock_screen.dart';
import 'package:supreme/presentation/waiting_list_screen.dart';

import '../../presentation/profile.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  List<Widget> screens = [TiresStockScreen(), WaitingListScreen(), ProfileScreen()];
  List<String> appBarTitles = ['Tires Stock', 'Waiting List', 'Profile'];
  int currentIndex = 0;
  void changeBottomNavItem(int index)
  {
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }


}