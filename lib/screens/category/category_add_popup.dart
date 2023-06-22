// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:money_management/models/category/category_model.dart';


ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async{
  showDialog(context: context, builder: (ctx){
    return SimpleDialog(
      title:const Text("Add Category"),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Category Name",
              border: OutlineInputBorder()
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(10),
        child: Row(
          children: [
            RadioButton(title: 'Income', type: CategoryType.income),
            RadioButton(title: 'Expense', type: CategoryType.expense)
          ],
        ),),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(onPressed: (){
        
          }, child:const Text("Add")),
        )
      ],
    );
  });

}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  // final CategoryType selectedCategoryType;

  const RadioButton({required this.title,required this.type,super.key});

 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, selectedCategory, Widget? _) {
            return Radio<CategoryType>(
             value: type,
             groupValue: selectedCategory,
             onChanged: (newValue){
              if(newValue == null)
              {
                return;
              }
              selectedCategoryNotifier.value = newValue;
              selectedCategoryNotifier.notifyListeners();
             });
          }
        ),
        Text(title)
      ],
    );
  }
}