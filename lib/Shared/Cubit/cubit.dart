import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Shared/Cubit/states.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppCubit extends Cubit <AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;
  void changeAppMode({bool fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeMoodState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMoodState());
      });
    }
  }
}