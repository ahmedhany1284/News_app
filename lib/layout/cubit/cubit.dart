import 'package:news_layout/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_layout/modules/business/business_screen.dart';
import 'package:news_layout/modules/science/science_screen.dart';
import 'package:news_layout/modules/settings/settings_screen.dart';
import 'package:news_layout/modules/sports/sports_screen.dart';
import 'package:news_layout/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());
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
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  bool? is_dark=false;


  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];
  void changeBottomNavBar(int index){
    cur_ind=index;
    if (index==1){
      getSports();
    }
    else if(index==2){
      getScience();
    }
    else if(index==4){

    }
    emit(NewsBottomNavState());
  }

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value?.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }



  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value?.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }




  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value?.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }



  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value?.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }





}