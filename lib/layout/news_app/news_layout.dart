import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/layout/cubit/cubit.dart';
import 'package:news_layout/layout/cubit/states.dart';
import 'package:news_layout/modules/search/search_screen.dart';
import 'package:news_layout/network/remote/dio_helper.dart';
import 'package:news_layout/shared/components/components.dart';
import 'package:news_layout/shared/cubit/cubit.dart';

bool isdark=false;
class NewLayout extends StatelessWidget {
  const NewLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
                'NewsApp'
            ),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  navigateto(context, SearchScreen(), );
                },
                icon:Icon(Icons.search),
            ),
            IconButton(
              icon:Icon(!AppCubit.get(context).isDark!?Icons.light_mode:Icons.dark_mode),
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },

            ),
          ],
        ),
        body: cubit.screens[cubit.cur_ind],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.cur_ind,
          onTap: (index){
            cubit.changeBottomNavBar(index);
          },
          items:cubit.bottomItem,

        ),
      );
      }
    );
  }
}
