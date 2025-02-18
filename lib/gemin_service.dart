import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;
  List<Map<String, String?>> _conversationContext = [];

  GeminiService(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
        );

  Future<String?> sendMessage(String message) async {
    final content = Content.text(message);
    _conversationContext.add({'role': 'user', 'content': message});

    final response = await _model.generateContent(
      _conversationContext.map((msg) => Content.text(msg['content']!)).toList(),
    );

    _conversationContext.add({'role': 'assistant', 'content': response.text});
    return response.text;
  }
}
