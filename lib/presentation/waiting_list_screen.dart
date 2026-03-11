import 'package:flutter/material.dart';
import '../core/utilities/waiting_customer_status.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_waiting_list_item.dart';

class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
      child: Column(
        children: [
          CustomTextField(hintText: 'Search Customer Name'),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return CustomWaitingListItem(customerModel: waitingCustomersData[index]);
            },
              itemCount: waitingCustomersData.length,
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingCustomerModel {
  final String customerName;
  final String phoneNumber;
  final String tireSize;
  final String tireBrand;
  final String notes;
  final String date;
  final WaitingCustomerStatus customerStatus;

  WaitingCustomerModel({
    required this.customerName,
    required this.phoneNumber,
    required this.tireSize,
    required this.tireBrand,
    required this.notes,
    required this.date,
    required this.customerStatus,
  });
}

List<WaitingCustomerModel> waitingCustomersData = [
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  WaitingCustomerModel(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
];

