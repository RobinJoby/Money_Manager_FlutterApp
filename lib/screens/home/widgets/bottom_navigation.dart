import 'package:flutter/material.dart';

import '../screen_home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, updatedIndex, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex){
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Transactions"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category")
        ]);
      }
    );
  }
}