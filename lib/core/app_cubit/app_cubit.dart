import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/core/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  int currentIndex = 0;
  void changeBottomNavItem(int index)
  {
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }


}