import 'package:flutter/material.dart';
import 'package:samir_store/ui/tab/home_tab.dart';
import 'package:samir_store/ui/widget/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(),
          body: HomeTab(),
        )
      ],
    );
  }
}
