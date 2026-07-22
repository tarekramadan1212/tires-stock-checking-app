import 'package:supreme/data/customers/customers_models/waiting_customer_model.dart';
import 'package:supreme/data/customers/customers_services/message_service/base_message_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsAppMessageServiceImpl implements BaseMessageServices {
  @override
  Future<void> sendWhatsAppMessage({
    required WaitingCustomerModel customerModel,
    required String message,
  }) async {
    final fullPhoneNumber = customerModel.countryCode + customerModel.phoneNumber;
    final link = WhatsAppUnilink(
      phoneNumber: fullPhoneNumber,
      text: message,
    );
    if (await canLaunchUrl(link.asUri())) {
      await launchUrl(link.asUri(), mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not launch WhatsApp");
    }
  }
}
