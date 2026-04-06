import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/core/app_cubit/app_states.dart';
import 'package:supreme/core/utilities/helpers/cache_helper.dart';
import 'package:supreme/presentation/tires_stock_screen.dart';
import 'package:supreme/presentation/waiting_customers/waiting_list_screen.dart';

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

  bool _isDark = false;
  bool get isDark => _isDark;
  final cacheHelper = CacheHelper.getInstance();
  void toggleTheme(bool value)
  {
    _isDark = value;
    cacheHelper.putBool('isDark', value);
    emit(ToggleThemeState());
  }


}