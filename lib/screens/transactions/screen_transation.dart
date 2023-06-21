import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding:const EdgeInsets.all(10),
      itemBuilder: (ctx,index){
      return const Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            child: Text("12 Dec"),),
          title: Text("10000"),
          subtitle: Text("Travel"),
        ),
      );
    }, separatorBuilder: (ctx,index){
      return const SizedBox(
        height: 10,
      );
    }, itemCount: 10);
  }
}