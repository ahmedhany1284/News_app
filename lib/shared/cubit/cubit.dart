import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/network/local/cacheHelper.dart';
import 'package:news_layout/shared/cubit/states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromshard })
  {
    if(fromshard!=null){
      isDark=fromshard;
      emit(AppChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }



  }
}