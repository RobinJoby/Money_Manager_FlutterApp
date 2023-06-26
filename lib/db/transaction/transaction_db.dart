import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions{
  Future<void> addTransaction(TransactionModel obj);

}

class TransactionDb implements TransactionDbFunctions{

  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();
  
  factory TransactionDb(){
    return instance;
  }
  
  @override
  Future<void> addTransaction(TransactionModel obj) async{
    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDb.put(obj.id, obj);
  }

}