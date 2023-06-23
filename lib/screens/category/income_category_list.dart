import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';

import '../../models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListNotifier,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(itemBuilder: (ctx,index){
          final data = newList[index];
          return Card(
            child: ListTile(
              title: Text(data.name),
              trailing: IconButton(onPressed: (){
                CategoryDb.instance.deleteCategory(data.id);
              }, icon: const Icon(Icons.delete))
            ),
          );
        }, separatorBuilder: (ctx,index){
          return const SizedBox(
            height: 10,
          );
        }, itemCount: newList.length);
      }
    );
  }
}