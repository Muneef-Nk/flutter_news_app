import 'package:flutter/material.dart';
import 'package:news_app/controller/bottom_navigation_controller.dart';
import 'package:news_app/utils/color_constant.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationController>(context);
    return Scaffold(
        body: provider.screens[provider.currentIndex],
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  provider.changeBottomItem(0);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.currentIndex == 0 ? primary : light,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.home,
                    color: provider.currentIndex == 0 ? Colors.white : primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.changeBottomItem(1);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.currentIndex == 1 ? primary : light,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.search,
                    color: provider.currentIndex == 1 ? Colors.white : primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.changeBottomItem(2);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.currentIndex == 2 ? primary : light,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.bookmark_outline,
                    color: provider.currentIndex == 2 ? Colors.white : primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.changeBottomItem(3);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.currentIndex == 3 ? primary : light,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.person,
                    color: provider.currentIndex == 3 ? Colors.white : primary,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
