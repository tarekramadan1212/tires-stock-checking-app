import 'package:flutter/material.dart';
import 'package:supreme/core/constants/app_colors.dart';

import '../../core/utilities/demo_data.dart';
import '../../core/widgets/custom_text_field.dart';

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
