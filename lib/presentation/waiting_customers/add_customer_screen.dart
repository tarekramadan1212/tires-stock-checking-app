import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key, this.customer});

  final WaitingCustomerModel? customer;

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  List<String> tireBrands = [];

  List<String> _selectedBrands = [];

  final TextEditingController creatingNewBrandController =
      TextEditingController();

  final TextEditingController _customerNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+973';
  String _countryFlag = 'BH';

  final TextEditingController _sizeController = TextEditingController();

  final TextEditingController _brandController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();

  final cubit = sl<WaitingListCubit>();

  List<TextEditingController> priceControllers = [];

  void updateControllers() {
    if (widget.customer == null) return;
    while (widget.customer!.tireBrand.length > priceControllers.length) {
      priceControllers.add(TextEditingController());
    }
    while (widget.customer!.tireBrand.length < priceControllers.length) {
      priceControllers.last.dispose();
      priceControllers.removeLast();
    }
    if (widget.customer!.prices.isNotEmpty) {
      for (int i = 0; i < widget.customer!.prices.length; i++) {
        priceControllers[i].text = widget.customer!.prices[i].toString();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cubit.getSavedBrands(key: 'tireBrands');
    _customerNameController.text = widget.customer?.customerName ?? '';
    _phoneController.text = widget.customer?.phoneNumber ?? '';
    _countryCode = widget.customer?.countryCode ?? '973';
    _countryFlag = widget.customer?.countryFlag ?? 'BH';
    print('Init: $_countryCode\n $_countryFlag');
    _sizeController.text = widget.customer?.tireSize ?? '';
    _brandController.text = widget.customer?.tireBrand.join(',') ?? '';
    _selectedBrands = widget.customer?.tireBrand ?? [];
    _notesController.text = widget.customer?.notes ?? '';
    updateControllers();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _customerNameController.dispose();
    _phoneController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    _phoneFocusNode.dispose();
    for (var controller in priceControllers) {
      controller.dispose();
    }
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
                              children: _selectedBrands.asMap().entries.map((
                                brand,
                              ) {
                                final index = brand.key;
                                final value = brand.value;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      title: Text('Price for $value'),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2.0,
                                          ),
                                          child: CustomTextField(
                                            prefixIcon: const Icon(
                                              Icons.attach_money,
                                            ),
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
                          BlocConsumer<WaitingListCubit, WaitingCustomerState>(
                            listenWhen: (prev, current) =>
                                current.addPriceState != prev.addPriceState,
                            listener: (context, state) {
                              if (state.addPriceState == BlocStates.success) {
                                showSuccessSnackBar(
                                  context,
                                  'Successful action, now you can inform the customer',
                                );

                                // final navigator = Navigator.of(context);
                                //
                                // Future.delayed(
                                //   const Duration(milliseconds: 500),
                                //   () {
                                //     if (navigator.canPop()) {
                                //       navigator.pop();
                                //     }
                                //   },
                                // );
                              } else if (state.addPriceState ==
                                  BlocStates.error) {
                                showErrorSnackBar(context, state.errorMessage!);
                              }
                            },
                            builder: (context, state) {
                              final prices = state.waitingCustomers
                                  .firstWhere(
                                    (customer) =>
                                        customer.id == widget.customer!.id,
                                  )
                                  .prices;
                              return Column(
                                children: [
                                  CustomButton(
                                    child:
                                        state.addPriceState ==
                                            BlocStates.loading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            widget.customer!.prices.isEmpty
                                                ? 'Add Price'
                                                : 'Update Price ... Sure?',
                                          ),
                                    onPressed: () {
                                      final List<String> prices =
                                          priceControllers
                                              .map((element) => element.text)
                                              .toList();
                                      cubit.addPrice(
                                        id: widget.customer!.id!,
                                        prices: prices
                                            .map(
                                              (element) =>
                                                  double.tryParse(element) ??
                                                  0.0,
                                            )
                                            .toList(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  CustomButton(
                                    onPressed: prices.isEmpty
                                        ? null
                                        : () {
                                            final updatedModel = state
                                                .waitingCustomers
                                                .firstWhere(
                                                  (c) =>
                                                      c.id ==
                                                      widget.customer!.id,
                                                  orElse: ()=> widget.customer!,
                                                );
                                            cubit.sendWhatsAppMessage(
                                              customerModel: updatedModel,
                                            );
                                          },
                                    color: Colors.green.withValues(alpha: 0.6),
                                    child:
                                        state.sendWhatsAppMessageState ==
                                            BlocStates.loading
                                        ? CircularProgressIndicator()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                prices.isEmpty
                                                    ? 'Add Prices To enable WhatsApp Message'
                                                    : 'Send WhatsApp Message',
                                              ),
                                              SizedBox(width: 8.0),
                                              FaIcon(FontAwesomeIcons.whatsapp),
                                            ],
                                          ),
                                  ),
                                ],
                              );
                            },
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
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) return 'Customer name is required';
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
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
                  IntlPhoneField(
                    focusNode: _phoneFocusNode,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[270],
                      hintText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.number.isEmpty)
                        return 'Phone number is required';
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _phoneController,
                    initialCountryCode: widget.customer?.countryFlag ?? 'BH',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Before: $_countryCode\n $_countryFlag');
                      _countryCode = country.dialCode;
                      _countryFlag = country.flag;
                      print('After: $_countryCode\n $_countryFlag');
                    },
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
                    prefixIcon: const Icon(Icons.straighten),
                    validator: (value) {
                      if (value!.isEmpty) return 'Tire size is required';
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
                    prefixIcon: const Icon(Icons.branding_watermark),
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) return 'Tire brand is required';
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    hintText: 'Michelin',
                    controller: _brandController,
                  ),

                  BlocBuilder<WaitingListCubit, WaitingCustomerState>(
                    buildWhen: (prev, current) =>
                        prev.addNewBrandState != current.addNewBrandState ||
                        prev.getSavedBrandsState != current.getSavedBrandsState,
                    builder: (context, state) {
                      return StatefulBuilder(
                        builder: (context, setLocalState) {
                          if (state.getSavedBrandsState == BlocStates.success) {
                            tireBrands = state.savedSelectableBrands;
                          }
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
                                    _brandController.text =
                                        _selectedBrands.isNotEmpty
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
                      );
                    },
                  ),
                  InkWell(
                    splashColor: Colors.grey.withValues(alpha: 0.6),
                    highlightColor: Colors.deepOrangeAccent.withValues(
                      alpha: 0.6,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.46,
                      child: Ink(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        height: 42,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add New Brand',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Create a New Brand'),
                          content: Form(
                            key: _dialogFormKey,
                            child: CustomTextField(
                              prefixIcon: const Icon(Icons.add_business),
                              controller: creatingNewBrandController,
                              hintText: 'Enter a New Brand',
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Enter a new Brand to create';
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                if (!_dialogFormKey.currentState!.validate())
                                  return;

                                tireBrands.add(creatingNewBrandController.text);
                                cubit.addNewBrand(
                                  brands: tireBrands,
                                  key: 'tireBrands',
                                );
                                creatingNewBrandController.clear();
                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                          ],
                        ),
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
                    prefixIcon: const Icon(Icons.notes),
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
                      listenWhen: (prev, current) {
                        if (prev.addCustomerState != current.addCustomerState ||
                            prev.updateCustomerState !=
                                current.updateCustomerState) {
                          return true;
                        }
                        return false;
                      },
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
                        } else if (state.addCustomerState ==
                                BlocStates.loading ||
                            state.updateCustomerState == BlocStates.loading) {}
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            final branchId = context
                                .read<AuthBloc>()
                                .getUserData
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
                              prices: priceControllers
                                  .map(
                                    (controller) =>
                                        double.tryParse(controller.text) ?? 0.0,
                                  )
                                  .toList(),
                              countryCode: _countryCode,
                              countryFlag: _countryFlag,
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
                                countryCode: widget.customer!.countryCode,
                                countryFlag: widget.customer!.countryFlag,
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
