import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/customers/customers_datasource/I_customers_datasource.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

class CustomersDatasourceImpl implements ICustomersDatasource {
  final SupabaseClient client;

  CustomersDatasourceImpl({required this.client});

  @override
  Future<WaitingCustomerModel> addNewWaitingCustomer({
    required WaitingCustomerModel waitingCustomerModel,
  }) async {
    final data=  await client
        .from('waiting_customers')
        .insert(waitingCustomerModel.toMap())
        .select()
        .single();
    return WaitingCustomerModel.fromJson(data);
  }

  @override
  Future<WaitingCustomerModel> deleteWaitingCustomer({required int customerId}) async {
    final data = await client.from('waiting_customers').delete().eq('id', customerId).select();
    if(data.isNotEmpty) return WaitingCustomerModel.fromJson(data.first);
    throw Exception('Something went wrong');
  }

  @override
  Future<List<WaitingCustomerModel>> getAllWaitingCustomers() async {
    final response = await client.from('waiting_customers').select();
    return response.map((json) {
      return WaitingCustomerModel.fromJson(json);
    }).toList();
  }

  @override
  Future<WaitingCustomerModel> updateWaitingCustomerData({
    required WaitingCustomerModel originalModel,
    required WaitingCustomerModel updatedModel,
  }) async {
    final changes = _calculateChanges(originalModel, updatedModel);
    if(changes.isEmpty)return originalModel;
    final data = await client
        .from('waiting_customers')
        .update(changes)
        .eq('id', originalModel.id!).select().single();
    return WaitingCustomerModel.fromJson(data);
  }

  Map<String, dynamic> _calculateChanges(
      WaitingCustomerModel originalModel, WaitingCustomerModel updatedModel)
  {
    final changes = <String, dynamic>{};
    if(originalModel.customerName != updatedModel.customerName)changes['customer_name'] = updatedModel.customerName;
    if(originalModel.phoneNumber != updatedModel.phoneNumber)changes['phone'] = updatedModel.phoneNumber;
    if(originalModel.tireSize != updatedModel.tireSize)changes['tire_size'] = updatedModel.tireSize;
    if(originalModel.tireBrand != updatedModel.tireBrand)changes['brand'] = updatedModel.tireBrand;
    if(originalModel.notes != updatedModel.notes)changes['notes'] = updatedModel.notes;
    return changes;
  }

  @override
  Future<List<WaitingCustomerModel>> deleteSeveralWaitingCustomers({required List<int> selectedCustomersIds}) async{
    final data = await client.from('waiting_customers').delete().inFilter('id', selectedCustomersIds).select();
    return data.map((item) =>WaitingCustomerModel.fromJson(item)).toList();
  }
}
