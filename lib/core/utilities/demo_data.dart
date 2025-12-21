import 'package:flutter/cupertino.dart';
import 'package:supreme/core/utilities/waiting_customer_status.dart';
import 'package:supreme/core/widgets/tires_item_widget.dart';

import '../widgets/custom_waiting_list_item.dart';

List<Widget> stockItem = [
  TiresItemWidget(
    sizeAndBrand: '215/55/17 MICHELIN',
    quantity: 120,
    cost: 100,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '265/65/17 KINFOREST',
    quantity: 120,
    cost: 80,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '265/70/17 KINFOREST',
    quantity: 0,
    cost: 88,
    inStock: false,
  ),
  TiresItemWidget(
    sizeAndBrand: '195/65/15 YOKOHAMA',
    quantity: 54,
    cost: 40,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '225/65/17 GOODYEAR',
    quantity: 0,
    cost: 180,
    inStock: false,
  ),
  TiresItemWidget(
    sizeAndBrand: '215/55/17 BRIDGESTONE',
    quantity: 25,
    cost: 170,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '265/70/17 SUMITOMO',
    quantity: 4,
    cost: 190,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '215/55/17 MICHELIN',
    quantity: 120,
    cost: 100,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '265/65/17 KINFOREST',
    quantity: 120,
    cost: 80,
    inStock: true,
  ),
  TiresItemWidget(
    sizeAndBrand: '265/70/17 KINFOREST',
    quantity: 0,
    cost: 88,
    inStock: false,
  ),
];

List<Widget> waitingCustomers = [
  CustomWaitingListItem(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: NotifiedStatus(),
  ),
  CustomWaitingListItem(
    customerName: 'Mohamed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: PendingStatus(),
  ),
  CustomWaitingListItem(
    customerName: 'Tarek',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: PendingStatus(),
  ),
  CustomWaitingListItem(
    customerName: 'Gamal',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: PendingStatus(),
  ),
  CustomWaitingListItem(
    customerName: 'Ahmed',
    phoneNumber: '01012345678',
    tireSize: '215/55/17 MICHELIN',
    tireBrand: 'Michelin',
    notes: 'He needs 2 tires',
    date: '12/12/2023',
    customerStatus: PendingStatus(),
  ),
];
