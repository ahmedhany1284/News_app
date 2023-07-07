import 'package:news_layout/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_layout/modules/business/business_screen.dart';
import 'package:news_layout/modules/science/science_screen.dart';
import 'package:news_layout/modules/settings/settings_screen.dart';
import 'package:news_layout/modules/sports/sports_screen.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInintialState());
  static NewsCubit get(context)=>BlocProvider.of(context);


  int cur_ind=0;
  List<BottomNavigationBarItem>bottomItem=[
    BottomNavigationBarItem(
        icon:Icon(Icons.business),
      label: 'Business',

    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.sports),
      label: 'Sports',

    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.science),
      label: 'science',

    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.settings),
      label: 'Settings',

    ),
  ];

  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),

  ];
  void changeBottomNavBar(int index){
    cur_ind=index;
    emit(NewsBottomnavState());
  }
}