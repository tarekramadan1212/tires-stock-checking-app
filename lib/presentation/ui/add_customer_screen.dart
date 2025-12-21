import 'package:flutter/material.dart';
import 'package:supreme/core/constants/app_colors.dart';

import '../../core/widgets/custom_text_field.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Customer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 5),
          child: Column(
            spacing: 3.5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Customer Request',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Customer Name',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextField(hintText: 'Customer Name'),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextField(hintText: 'Phone Number'),
              Text(
                'Tire Size',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextField(hintText: '215/55/17'),
              Text(
                'Tire Brand',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextField(hintText: 'Michelin'),
              Text(
                'Notes',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextField(
                hintText: 'Additional Details ....',
                maxLines: 4,
                maxLength: 300,
              ),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarySeed,
                    elevation: 0,

                  ),
                  child: Text('Add To The Waiting List'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
