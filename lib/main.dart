import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_layout/layout/cubit/states.dart';
import 'package:news_layout/layout/news_app/news_layout.dart';
import 'package:news_layout/network/local/cacheHelper.dart';
import 'package:news_layout/network/remote/dio_helper.dart';
import 'package:news_layout/layout/cubit/cubit.dart';

import 'shared/bloc_observer.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key: 'isDark')??false;
  bool? is_eg=CacheHelper.getData(key: 'is_eg')??false;

  runApp( MyApp(isDark));
}
class MyApp extends StatelessWidget {
   MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  final bool isDark;
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (BuildContext context) =>AppCubit()..changeAppMode(
          fromshard: isDark,
        ),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch:Colors.deepOrange,
              scaffoldBackgroundColor:Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle:SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,

              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor:Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
              ),
            ),
            darkTheme:ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarBrightness: Brightness.light,
                ),
                backgroundColor: Colors.grey[900],
                elevation: 0.0,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
              ),
            ),
            themeMode: AppCubit.get(context).isDark != true ? ThemeMode.light : ThemeMode.dark,
            home:  NewLayout(),
          );
        },

      ),
    );
  }
}

