import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryId;

  @override
  void initState() {
    
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }
  /* 
  purpose
  date 
  Amount
  Income\Expense
  CategoryType
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //purpose
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Purpose"
                )
              ),
              const SizedBox(
                height: 10,
              ),
              //amount
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ammount"
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //date
              
              TextButton.icon(onPressed: () async{
                final _selectedDateTemp = await showDatePicker(context: context,
                 initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                   lastDate: DateTime.now());
                   if(_selectedDateTemp==null){
                    return;
                   }
                   else{
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                   }
              }, icon:const Icon(Icons.calendar_today), label: Text(_selectedDate == null?'Select Date': _selectedDate.toString()))
              
              ,
              
              //category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(value: CategoryType.income, groupValue: _selectedCategoryType, onChanged: (newValue){
                       setState(() {
                          _selectedCategoryType = CategoryType.income;
                          _categoryId = null;
                       });
                      }),
                      const Text("Income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: CategoryType.expense, groupValue: _selectedCategoryType, onChanged: (newValue){
                        setState(() {
                           _selectedCategoryType = CategoryType.expense;
                           _categoryId = null;
                        });
                      }),
                      const Text("Expense")
                    ],
                  ),
                ],
              ),
              //Category
              DropdownButton<String>(
                value: _categoryId,
                hint: const Text("Select Category"),
                items:
                (_selectedCategoryType == CategoryType.income ? CategoryDb.instance.incomeCategoryListNotifier : CategoryDb.instance.expenseCategoryListNotifier)
                .value.map((e){
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name));
              }).toList(), onChanged: (selectedValue){
                setState(() {
                  _categoryId = selectedValue;
                });
              }),
              const SizedBox(
                height: 10,
              ),
              //submit
              ElevatedButton(onPressed: (){

              }, child: const Text("Submit"),)
              
            ],
          ),
        ),
      ),
    );
  }
}