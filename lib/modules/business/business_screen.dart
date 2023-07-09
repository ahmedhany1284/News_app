import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/layout/cubit/cubit.dart';
import 'package:news_layout/layout/cubit/states.dart';
import 'package:news_layout/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=NewsCubit.get(context);
    return BlocConsumer<NewsCubit,NewsStates>(

      listener: (context,state){},
      builder: (context,state){
        var list=cubit.business;
        return articleBuilder(list);
      },
    );
  }
}


