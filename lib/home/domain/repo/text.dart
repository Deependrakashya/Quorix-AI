import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final model = GenerativeModel(
    model: 'gemini-2.0-pro-exp-02-05',
    apiKey: "AIzaSyDXGt9gbIEMY8GG51qOoYaB5PEQEqh1pZM",
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
  );

  final chat = model.startChat(history: [
    Content.multi([TextPart('hii\n'), TextPart('your are deep ai bot')]),
    Content.model([
      TextPart('Hello! How are you doing today?\n'),
    ]),
  ]);
  final message = 'who are you ';
  final content = Content.text(message);

  final response = await chat.sendMessage(content);
  print(response.text);
}
