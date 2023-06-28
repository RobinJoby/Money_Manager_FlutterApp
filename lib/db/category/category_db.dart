// ignore_for_file: constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions{
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String catergoryId);
}

class CategoryDb implements CategoryDbFunctions{

  CategoryDb.internal();

  static CategoryDb instance = CategoryDb.internal();

  factory CategoryDb(){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
   
   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   _categoryDB.put(value.id,value);
   refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async{

    final _allCategories = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category){
      if(category.type == CategoryType.income)
      {
        incomeCategoryListNotifier.value.add(category);
      }
      else{
        expenseCategoryListNotifier.value.add(category);
      }
      incomeCategoryListNotifier.notifyListeners();
      expenseCategoryListNotifier.notifyListeners();
    });
  }
  
  @override
  Future<void> deleteCategory(String catergoryId) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(catergoryId);
    refreshUI();
  }
  
}