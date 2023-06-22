// ignore_for_file: constant_identifier_names

import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions{
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions{
  @override
  Future<void> insertCategory(CategoryModel value) async {
   
   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   _categoryDB.add(value);
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }
  
}