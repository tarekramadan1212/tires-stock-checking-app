import 'package:flutter/material.dart';

class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Waiting list',style: TextStyle(color: Colors.black, fontSize: 30),),
      ],
    );
  }
}
