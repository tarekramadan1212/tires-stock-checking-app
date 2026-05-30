import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_bloc.dart';
import 'package:supreme/business_logic/waiting_list_cubit/waiting_list_states.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';
import 'package:supreme/core/utilities/helpers/snack_bar_helpers.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import '../../business_logic/waiting_list_cubit/waiting_list_cubit.dart';
import '../../core/services/service_locator.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/utilities/helpers/convert_brands_into_list.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key, this.customer});

  final WaitingCustomerModel? customer;

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final List<String> tireBrands = const [
    'Michelin',
    'Bridgestone',
    'Continental',
    'Goodyear',
    'Pirelli',
    'Hankook',
    'Yokohama',
    'Toyo',
    'Nexen',
  ];

  List<String> _selectedBrands = [];

  final TextEditingController _customerNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _sizeController = TextEditingController();

  final TextEditingController _brandController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final cubit = sl<WaitingListCubit>();

  List<TextEditingController> priceControllers = [];

  void updateControllers() {
    while (_selectedBrands.length > priceControllers.length) {
      priceControllers.add(TextEditingController());
    }
    while (_selectedBrands.length < priceControllers.length) {
      priceControllers.last.dispose();
      priceControllers.removeLast();
    }
  }

  @override
  void initState() {
    super.initState();
    _customerNameController.text = widget.customer?.customerName ?? '';
    _phoneController.text = widget.customer?.phoneNumber ?? '';
    _sizeController.text = widget.customer?.tireSize ?? '';
    _brandController.text = widget.customer?.tireBrand.join(',') ?? '';
    _selectedBrands = widget.customer?.tireBrand ?? [];
    updateControllers();
    _notesController.text = widget.customer?.notes ?? '';
  }

  @override
  void dispose() {
    _notesController.dispose();
    _customerNameController.dispose();
    _phoneController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Add New Customer')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 5),
            child: Form(
              key: _formKey,
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
                  if (widget.customer != null)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'The Price Section',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _selectedBrands.asMap().entries.map((brand) {
                                final index = brand.key;
                                final value = brand.value;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                                      title: Text('Price for $value'),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                          child: CustomTextField(
                                            keyboardType: TextInputType.number,
                                            controller: priceControllers[index],
                                            hintText: '0.00',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          CustomButton(
                            child: Text('Submit Price'),
                            onPressed: (){},
                          ),
                        ],
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
                    validator: (value){
                      if(value!.isEmpty) return 'Customer name is required';
                      return null;
                    },
                    textInputAction: TextInputAction.next,
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
                    validator: (value){
                      if(value!.isEmpty) return 'Phone number is required';
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
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
                    validator: (value){
                      if(value!.isEmpty) return 'Tire size is required';
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
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
                    validator: (value){
                      if(value!.isEmpty) return 'Tire brand is required';
                      return null;
                    },
                    textInputAction: TextInputAction.next,
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
                                _brandController.text = _selectedBrands.isNotEmpty
                                    ? '${_selectedBrands.join(', ')},'
                                    : '';
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
                    textInputAction: TextInputAction.done,
                    hintText: 'Additional Details ....',
                    maxLines: 4,
                    maxLength: 300,
                    controller: _notesController,
                  ),
                  SizedBox(height: 6.0),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: BlocConsumer<WaitingListCubit, WaitingCustomerState>(
                      listener: (context, state) {
                        if (state.addCustomerState == BlocStates.success ||
                            state.updateCustomerState == BlocStates.success) {
                          _customerNameController.clear();
                          _phoneController.clear();
                          _sizeController.clear();
                          _brandController.clear();
                          _notesController.clear();
                          showSuccessSnackBar(context, 'Successful action');

                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (context.mounted) Navigator.pop(context);
                          });
                        } else if (state.addCustomerState == BlocStates.error ||
                            state.updateCustomerState == BlocStates.error) {
                          showErrorSnackBar(context, state.errorMessage!);
                        } else if (state.addCustomerState == BlocStates.loading ||
                            state.updateCustomerState == BlocStates.loading) {}
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {

                            if(!_formKey.currentState!.validate()) return;
                            final branchId = context
                                .read<AuthBloc>()
                                .userData
                                .branchId;
                            final updatedModel = WaitingCustomerModel(
                              branchId: branchId!,
                              customerName: _customerNameController.text,
                              phoneNumber: _phoneController.text,
                              tireSize: _sizeController.text,
                              tireBrand: convertTiresBrandsIntoList(
                                tireBrands: _brandController.text,
                              ),
                              notes: _notesController.text,
                              status: widget.customer?.status ?? 'pending',
                              createdAt:
                                  widget.customer?.createdAt ??
                                  DateTime.now().toString(),
                              prices: priceControllers.map((controller) => controller.text).toList(),
                            );

                            if (widget.customer == null) {
                              await cubit.addNewCustomer(updatedModel);
                            } else {
                              final originalModel = WaitingCustomerModel(
                                branchId: branchId,
                                customerName: widget.customer!.customerName,
                                id: widget.customer!.id,
                                tireBrand: widget.customer!.tireBrand,
                                tireSize: widget.customer!.tireSize,
                                notes: widget.customer!.notes,
                                phoneNumber: widget.customer!.phoneNumber,
                                status: widget.customer!.status,
                                createdAt: widget.customer!.createdAt,
                                prices: widget.customer!.prices,
                              );
                              await cubit.updateCustomerData(
                                originalModel: originalModel,
                                updatedModel: updatedModel,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primarySeed,
                            elevation: 0,
                          ),
                          child: widget.customer == null
                              ? state.addCustomerState == BlocStates.loading
                                    ? CircularProgressIndicator()
                                    : Text('Add To The Waiting List')
                              : state.updateCustomerState == BlocStates.loading
                              ? CircularProgressIndicator()
                              : Text('Update User'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> getTiresBrandsToList({required String tireBrands}) {
  if (tireBrands.isEmpty) return [];
  List<String> brands = [];
  String brand = '';
  for (int i = 0; i < tireBrands.length; i++) {
    if (tireBrands[i] == ',') {
      brands.add(brand.trim());
      brand = '';
    } else {
      brand += tireBrands[i];
    }
  }
  return brands;
}
