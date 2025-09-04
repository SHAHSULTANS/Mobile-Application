import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/app_constants.dart';

class ChatService {
  static Future<String> sendMessage(String message) async {
    final url = Uri.parse(AppConstants.baseUrl);

    final body = {
      "model": "openai/gpt-3.5-turbo", // Model ID ঠিক আছে কিনা নিশ্চিত হও
      "messages": [
        {"role": "user", "content": message},
      ],
      "max_tokens": 500,
      "temperature": 0.7,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiKey}",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices']?[0]?['message']?['content'] ?? "No response";
      } else {
        // Debugging info
        print("❌ API Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return "Error: API call failed (${response.statusCode})";
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      return "Error: Something went wrong.";
    }
  }
}
