import 'dart:convert';

import 'package:chatgpt_chat_app_ai/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future<String> generateResponse(String msg) async {
    final uri = Uri.https(apiBaseUrl, apiEndPoint);
    final encodedJson = jsonEncode(generatePostBody(msg));
    final response = await http.post(uri, headers: apiHeader, body: encodedJson);
    final convertedJson = utf8.decode(response.bodyBytes);//for support utf-8
    final responseMap = jsonDecode(convertedJson);
    return responseMap['choices'][0]['text'];
  }
}
