import 'package:flutter/material.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/bottom_nav_view_model.dart';
import 'package:untitled8/viewModels/home_view_model.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavViewModel>(
      builder: (context, model, child) => BottomNavigationBar(
        onTap: model.switchPages,
        currentIndex: model.selectIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
