import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/layout/cubit/cubit.dart';
import 'package:news_layout/layout/cubit/states.dart';
import 'package:news_layout/shared/components/components.dart';

class SearchScreen extends StatelessWidget {


  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list= NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  readonly: false,
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value){
                    if(value!.isEmpty){
                      return'Search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  icon: Icons.search,
                ),
              ),
              Expanded(
                  child: articleBuilder(list,loadabe: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
