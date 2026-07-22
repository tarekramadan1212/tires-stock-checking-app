import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';

abstract class BaseMessageServices{
  Future<void> sendWhatsAppMessage({required WaitingCustomerModel customerModel, required String message});
}