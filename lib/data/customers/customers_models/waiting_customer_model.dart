class WaitingCustomerModel {
  final String createdAt;
  final String customerName;
  final String phoneNumber;
  final String tireSize;
  final String tireBrand;
  final String notes;
  final String status;

  const WaitingCustomerModel({
    required this.customerName,
    required this.phoneNumber,
    required this.tireSize,
    required this.tireBrand,
    required this.notes,
    required this.status,
    required this.createdAt,
  });

  factory WaitingCustomerModel.fromJson(Map<String, dynamic> json) {
    return WaitingCustomerModel(
      customerName: json['customer_name'],
      phoneNumber: json['phone'],
      tireSize: json['tire_size'],
      tireBrand: json['brand'],
      notes: json['notes'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'customer_name': customerName,
      'phone': phoneNumber,
      'tire_size': tireSize,
      'brand': tireBrand,
      'notes': notes,
      'status': status,
      'created_at': createdAt,
    };
  }
}
