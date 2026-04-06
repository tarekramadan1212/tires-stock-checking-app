import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

import '../../business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import '../../core/services/service_locator.dart';
import '../../core/widgets/custom_text_field.dart';

class AddCustomerScreen extends StatelessWidget {
  AddCustomerScreen({super.key});

  final List<String> tireBrands = const [
    'Michelin',
    'Bridgestone',
    'Continental',
    'Goodyear',
    'Pirelli',
    'Hankook',
    'Yokohama',
  ];

  final List<String> _selectedBrands = [];
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final cubit = sl<WaitingListCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Add New Customer')),
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
                CustomTextField(
                  hintText: 'Customer Name',
                  controller: _customerNameController,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  hintText: 'Phone Number',
                  controller: _phoneController,
                ),
                Text(
                  'Tire Size',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  hintText: '215/55/17',
                  controller: _sizeController,
                ),
                Text(
                  'Tire Brand',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  hintText: 'Michelin',
                  controller: _brandController,
                ),
                StatefulBuilder(
                  builder: (context, setLocalState) {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: tireBrands.map((brand) {
                        return FilterChip(
                          label: Text(brand),
                          selected: _selectedBrands.contains(brand),
                          onSelected: (bool selected) {
                            setLocalState(() {
                              if (selected) {
                                _selectedBrands.add(brand);
                              } else {
                                _selectedBrands.remove(brand);
                              }
                              _brandController.text = _selectedBrands.join(', ');
                            });
                          },
                          selectedColor: AppColors.primarySeed.withValues(
                            alpha: 0.3,
                          ),
                          checkmarkColor: AppColors.primarySeed,
                        );
                      }).toList(),
                    );
                  },
                ),
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
                  controller: _notesController,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: BlocConsumer<WaitingListCubit, WaitingCustomerState>(
                    listener: (context, state)
                    {
                      if(state.addCustomerState == BlocStates.success)
                        {
                          print('success');
                        }
                      else if(state.addCustomerState == BlocStates.error)
                        {
                          print('Error -- ${state.errorMessage}');
                        }
                      else if(state.addCustomerState == BlocStates.loading)
                        {
                          print('loading');
                        }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () async {
                          final model = WaitingCustomerModel(
                            customerName: _customerNameController.text,
                            phoneNumber: _phoneController.text,
                            tireSize: _sizeController.text,
                            tireBrand: _brandController.text,
                            notes: _notesController.text,
                            status: CustomerStatus.pending,
                            createdAt: DateTime.now().toString(),
                          );
                          await cubit.addNewCustomer(model);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarySeed,
                          elevation: 0,
                        ),
                        child: state.addCustomerState == BlocStates.loading
                            ? CircularProgressIndicator()
                            : Text('Add To The Waiting List'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
