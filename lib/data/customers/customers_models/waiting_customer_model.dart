class WaitingCustomerModel {
  final int? id;
  final String createdAt;
  final String customerName;
  final String phoneNumber;
  final String tireSize;
  final List<String> tireBrand;
  final String notes;
  final String? status;
  final String branchId;
  final List<String> prices;

  const WaitingCustomerModel({
    this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.tireSize,
    required this.tireBrand,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.branchId,
    required this.prices,
  });

  factory WaitingCustomerModel.fromJson(Map<String, dynamic> json) {
    return WaitingCustomerModel(
      id: json['id'],
      customerName: json['customer_name'],
      phoneNumber: json['phone'],
      tireSize: json['tire_size'],
      tireBrand: List<String>.from(json['brand']??[]),
      notes: json['notes'],
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'],
      branchId: json['branch_id'],
      prices: List<String>.from(json['prices']??[]),
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
      'status': status ?? 'pending',
      'created_at': createdAt,
      'prices': prices,
    };
  }

  WaitingCustomerModel copyWith({
    int?id,
    String? status,
    String? branchId,
    String? createdAt,
    String? customerName,
    String? phoneNumber,
    String? tireSize,
    List<String>? tireBrand,
    String? notes,
    List<String>? prices,
  }) {
    return WaitingCustomerModel(
      id: id??this.id,
      status: status??this.status,
      branchId: branchId??this.branchId,
      createdAt: createdAt??this.createdAt,
      customerName: customerName??this.customerName,
      phoneNumber: phoneNumber??this.phoneNumber,
      tireSize: tireSize??this.tireSize,
      tireBrand: tireBrand??this.tireBrand,
      notes: notes??this.notes,
      prices: prices??this.prices,
    );
  }


}
