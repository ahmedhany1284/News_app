import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/layout/cubit/cubit.dart';
import 'package:news_layout/layout/cubit/states.dart';

class NewLayout extends StatelessWidget {
  const NewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (Buildcontext)=>NewsCubit(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder:(context,state){
          var cubit=NewsCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            title: Text('NewsApp'),
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon:Icon(Icons.search),
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
      ),
    );
  }
}
