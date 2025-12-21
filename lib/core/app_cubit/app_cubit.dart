import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/core/app_cubit/app_states.dart';
import 'package:supreme/presentation/ui/tires_stock_screen.dart';
import 'package:supreme/presentation/ui/waiting_list_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  List<Widget> screens = [TiresStockScreen(), WaitingListScreen()];
  List<String> appBarTitles = ['Tires Stock', 'Waiting List'];
  int currentIndex = 0;
  void changeBottomNavItem(int index)
  {
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }


}