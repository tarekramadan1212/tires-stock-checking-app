import 'package:flutter/material.dart';

List<WaitingCustomerStatus> waitingCustomerStatus = [
  PendingStatus(),
  NotifiedStatus(),
  CancelledStatus(),
  FullFilledStatus(),
];

abstract class WaitingCustomerStatus {
  String label;
  Color color;

  WaitingCustomerStatus(this.label, this.color);
}

class PendingStatus extends WaitingCustomerStatus {
  PendingStatus() : super('Pending', Colors.orange);
}

class NotifiedStatus extends WaitingCustomerStatus {
  NotifiedStatus() : super('Notified', Colors.green);
}

class CancelledStatus extends WaitingCustomerStatus {
  CancelledStatus() : super('Cancelled', Colors.red);
}

class FullFilledStatus extends WaitingCustomerStatus {
  FullFilledStatus() : super('Full Filled', Colors.blue);
}
