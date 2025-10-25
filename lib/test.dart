import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// final apiKey = "AIzaSyBjwEg4HBG60ZZdtJsbaZ5-_XkGk5-F2kc";

void main() async {
  final apiKey = "AIzaSyBjwEg4HBG60ZZdtJsbaZ5-_XkGk5-F2kc";

  await generateImage(apiKey);
}

// Function to generate an image using Gemini AI
Future<void> generateImage(String apiKey) async {
  final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=$apiKey');

  final body = jsonEncode({
    "contents": [
      {
        "role": "user",
        "parts": [
          {
            "text":
                "Generate a birthday card with beautiful floral decorations. The text should say:\n\"Happy Birthday! Wishing you a joyful year ahead!\""
          }
        ]
      }
    ],
    "generationConfig": {
      "temperature": 1,
      "topK": 40,
      "topP": 0.95,
      "maxOutputTokens": 8192,
      "responseMimeType": "application/json",
      "responseModalities": ["image"]
    }
  });

  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'}, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Response: $data'); // Check if it contains an image URL

    // Extract and print the image URL if available
    final imageUrl =
        data['candidates']?[0]['content']['parts']?[0]['fileData']?['fileUri'];
    if (imageUrl != null) {
      print('Generated Image URL: $imageUrl');
    } else {
      print('No image URL found in response.');
    }
  } else {
    print('Image generation failed: ${response.body}');
  }
}
