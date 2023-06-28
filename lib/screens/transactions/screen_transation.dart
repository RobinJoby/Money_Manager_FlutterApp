// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';

import '../../models/transaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final _value = newList[index];
                return 
                    Slidable(
                      key: Key(_value.id!),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(onPressed: (ctx){
                            TransactionDb.instance.deleteTransaction(_value.id!);
                          },
                          icon: Icons.delete,
                          label: 'delete',)
                        ],
                      ),
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundColor: _value.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                            child: Text(parseDate(_value.date)),
                          ),
                          title: Text('RS ${_value.amount}'),
                          subtitle: Text(_value.category.name),
                        ),
                      ),
                    );              
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return " ${_splitedDate.last}\n${_splitedDate.first}";
    // return '${date.day}\n${date.month}';
  }
}
