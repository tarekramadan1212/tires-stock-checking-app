import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 29), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_sharp, size: 29), label: 'Waiting'),
          ],
        ),
      ),
    );
  }
}
