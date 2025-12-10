import 'package:flutter/material.dart';

class TiresStockScreen extends StatelessWidget {
  const TiresStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Tires stock',style: TextStyle(color: Colors.black, fontSize: 30),),
        ],
      ),
    );
  }
}
