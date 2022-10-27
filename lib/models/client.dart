import 'package:appwrite/appwrite.dart';

class AWClient {
  late Client client;
  late Account account;
  late Databases databases;


  AWClient() {
    client = Client()
        .setEndpoint(
        'https://test.digiappwrite.webtron.io/v1') // Your Appwrite Endpoint
        .setProject('635a855adec12706d793') // Your project ID
        .setSelfSigned(
        status:
        true); // For self signed certificates, only use for development

    account = Account(client);
    databases = Databases(client);
  }
}
