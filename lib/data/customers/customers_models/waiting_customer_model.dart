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
  final List<double> prices;
  final String countryCode;
  final String countryFlag;

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
    required this.countryCode,
    required this.countryFlag,
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
      prices: (json['prices'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
      countryCode: json['country_code']??'+973',
      countryFlag: json['country_flag']??'BH',
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
      'country_code': countryCode,
      'country_flag': countryFlag
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
    List<double>? prices,
    String? countryCode,
    String? countryFlag,
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
      countryCode: countryCode??this.countryCode,
      countryFlag: countryFlag??this.countryFlag,
    );
  }

}
