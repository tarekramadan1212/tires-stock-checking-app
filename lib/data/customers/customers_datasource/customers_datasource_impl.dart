import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/customers/customers_datasource/I_customers_datasource.dart';
import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

class CustomersDatasourceImpl implements ICustomersDatasource{

  final SupabaseClient client;
  CustomersDatasourceImpl({required this.client});

  @override
  Future<void> addNewWaitingCustomer({required WaitingCustomerModel waitingCustomerModel}) async{
    await client.from('waiting_customers').insert(waitingCustomerModel.toMap());
    //TODO: update this method to Get the recently added row.
  }

  @override
  Future<void> deleteWaitingCustomer({required String customerId}) async{
    await client.from('waiting_customers').delete().eq('id', customerId);
  }

  @override
  Future<List<WaitingCustomerModel>> getAllWaitingCustomers() async{
    final response = await client.from('waiting_customers').select();
    return response.map((json){
      return WaitingCustomerModel.fromJson(json);
    }).toList();
  }

  @override
  Future<void> updateWaitingCustomerStatus({required WaitingCustomerModel waitingCustomerModel}) async{
    await client.from('waiting_customers').update(waitingCustomerModel.toMap());
    //TODO: update this method to Get the recently added row.
  }

}