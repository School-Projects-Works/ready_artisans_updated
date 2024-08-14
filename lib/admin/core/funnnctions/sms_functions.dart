import 'package:http/http.dart' as http;

const String baseUrl =
    'https://sms.arkesel.com/sms/api?action=send-sms&api_key=SmtPRE5HZk11Q3lKdHNGamJFRnE&to=PhoneNumber&from=SenderID&sms=YourMessage';

Future<bool> sendMessage(String phoneNumber, String message) async {
  try {
    final response = await http.get(Uri.parse(baseUrl
        .replaceFirst('PhoneNumber', phoneNumber)
        .replaceFirst('SenderID', 'HandyMan')
        .replaceFirst('YourMessage', message)));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
