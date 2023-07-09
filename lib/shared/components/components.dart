import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/layout/cubit/cubit.dart';
import 'package:news_layout/layout/cubit/states.dart';

Widget buildArticleItem(article)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children:
    [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: article['urlToImage'] == null
                  ? AssetImage('assets/images/No_images.jpeg')
                  : NetworkImage('${article['urlToImage']}') as ImageProvider<Object>,
              fit: BoxFit.cover,
            )
        ),
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Text(
                '${article['title']}',
                style: TextStyle(
                  fontWeight:FontWeight.w600,
                  fontSize: 18.0,
                ),
                maxLines: 3 ,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.length>0  ,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index]),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: list.length,
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);




Widget defaultFormField({
  required bool readonly,
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap, // Update the parameter name to onTap
  required String? Function(String?)? validate,
  required String label,
  required IconData icon,
  bool is_clickable=true,
}) {
  return TextFormField(
    readOnly: readonly,
    controller: controller,
    keyboardType: type,
    enabled: is_clickable,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(),
    ),
  );
}

void navigateto (context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(

    builder: (context)=>widget,
  ) ,
);