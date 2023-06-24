import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/category/category_add_popup.dart';
import 'package:money_management/screens/category/screen_category.dart';
import 'package:money_management/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management/screens/transactions/screen_add_transaction.dart';
import 'package:money_management/screens/transactions/screen_transation.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransactions(),ScreenCategory()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("MONEY MANAGER"),
      centerTitle: true,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if (selectedIndexNotifier.value == 0){
          // print("Add Transactions");
          Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
        }
        else{
          // print("Add Category");

          showCategoryAddPopup(context);
          // final _sample = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(),
          // name: 'Travel',
          // type: CategoryType.expense,);
          // CategoryDb().insertCategory(_sample);
        }

      },child:const Icon(Icons.add),),
      bottomNavigationBar:const BottomNavigation(),
      body: SafeArea(child: ValueListenableBuilder(valueListenable: selectedIndexNotifier,
       builder: (BuildContext ctx, int updatedIndex, Widget? _){
        return _pages[updatedIndex];
       })),      
    );
  }
}