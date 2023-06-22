import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/home/screen_home.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
  {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
  {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenHome(),
    );
  }
}