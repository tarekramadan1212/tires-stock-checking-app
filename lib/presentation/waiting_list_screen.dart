import 'package:flutter/material.dart';
import '../core/utilities/demo_data.dart';

class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return waitingCustomers[index];
    },
      itemCount: waitingCustomers.length,
    );
  }
}
