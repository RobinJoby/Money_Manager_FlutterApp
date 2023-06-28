import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions();

}

class TransactionDb implements TransactionDbFunctions{

  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();
  
  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);
  
  @override
  Future<void> addTransaction(TransactionModel obj) async{
    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDb.put(obj.id, obj);
  }

  Future<void> refresh() async{

    final _list = await getTransactions();
    _list.sort((first,second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();

  }
  
  @override
  Future<List<TransactionModel>> getTransactions() async{

    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
  }

}