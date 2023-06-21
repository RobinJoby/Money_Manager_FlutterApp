import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (ctx,index){
      return Card(
        child: ListTile(
          title: Text("Expense Category $index"),
          trailing:const Icon(Icons.delete),
        ),
      );
    }, separatorBuilder: (ctx,index){
      return const SizedBox(
        height: 10,
      );
    }, itemCount: 100);
  }
}