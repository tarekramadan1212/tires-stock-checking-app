
enum CustomerStatus { cancelled, pending, notified, completed }

class WaitingCustomerModel {
  final String createdAt;
  final String customerName;
  final String phoneNumber;
  final String tireSize;
  final String tireBrand;
  final String notes;
  final CustomerStatus? status;
  final String branchId;

  const WaitingCustomerModel({
    required this.customerName,
    required this.phoneNumber,
    required this.tireSize,
    required this.tireBrand,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.branchId,
  });

  factory WaitingCustomerModel.fromJson(Map<String, dynamic> json) {
    return WaitingCustomerModel(
      customerName: json['customer_name'],
      phoneNumber: json['phone'],
      tireSize: json['tire_size'],
      tireBrand: json['brand'],
      notes: json['notes'],
      status: json['status'] == null ?CustomerStatus.pending: CustomerStatus.values.byName(json['status']),
      createdAt: json['created_at'],
      branchId: json['branch_id']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branch_id': branchId,
      'customer_name': customerName,
      'phone': phoneNumber,
      'tire_size': tireSize,
      'brand': tireBrand,
      'notes': notes,
      'status': status?.name??'pending',
      'created_at': createdAt,
    };
  }
}
