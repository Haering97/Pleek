import 'package:appwrite/appwrite.dart';

class AWClient {
  late Client client;

  AWClient() {
    client = Client()
        .setEndpoint(
            'https://80-webtronaute-webtronappw-29irk4x2vmb.ws-eu71.gitpod.io/') // Your Appwrite Endpoint
        .setProject('634fdc9650e4f88d31d5') // Your project ID
        .setSelfSigned(
            status:
                true); // For self signed certificates, only use for development
  }
}
