import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';

class AIChatSession {
  final String apiKey;
  final String modelName;
  final GenerativeModel model;
  late final ChatSession chatSession; // Corrected type
  final List<Content> chatHistory = []; // Stores chat history
  final String botName = "Deep Mind AI";
  final String creatorName = "Deependra Kashyap";

  AIChatSession(this.apiKey, this.modelName)
      : model = GenerativeModel(model: modelName, apiKey: apiKey) {
    // Initialize chat session correctly
    log("Home repo $modelName");
    chatSession = model.startChat(history: [
      Content.text("Hi!"),
      Content.model([
        TextPart(
            "Hello! I am $botName, created by $creatorName. How can I help you?")
      ]),
    ]);

    // Add initial history
    chatHistory.addAll([
      Content.text("Hi!"),
      Content.model([
        TextPart(
            "Hello! I am $botName, created by $creatorName. How can I help you?")
      ]),
    ]);
  }

  Future<String> sendMessage(String userMessage) async {
    try {
      // Check if user is asking "Who are you?"
      if (_isAskingWhoAmI(userMessage)) {
        return "I am $botName, an AI assistant created by $creatorName. How can I assist you today?";
      }

      // Add user message to history
      chatHistory.add(Content.text(userMessage));

      // log(chatHistory[0].parts[0].toString());

      // Send message and maintain chat context
      final response = await chatSession.sendMessage(Content.text(userMessage));

      if (response.text != null) {
        // Add AI response to history
        chatHistory.add(Content.model([TextPart(response.text!)]));
        return response.text!;
      } else {
        return "No response from Gemini.";
      }
    } catch (e) {
      return "Error: Something went wrong. Please try again.";
    }
  }

  // Check if user asks about bot identity
  bool _isAskingWhoAmI(String message) {
    final lowerMsg = message.toLowerCase();
    return lowerMsg.contains("who are you") ||
        lowerMsg.contains("what's your name") ||
        lowerMsg.contains("who is this") ||
        lowerMsg.contains("tell me about yourself");
  }
}
