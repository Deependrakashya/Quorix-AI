import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIChatSession {
  final String apiKey;
  final String modelName;
  final GenerativeModel model;
  late ChatSession chatSession;
  final List<Content> chatHistory = []; // Store messages dynamically
  final String botName = "Quorix AI";
  final String creatorName = "Deependra Kashyap";

  AIChatSession(this.apiKey, this.modelName)
      : model = GenerativeModel(model: modelName, apiKey: apiKey) {
    log("Initializing AIChatSession with model: $modelName");

    // Restore history if available, else start fresh
    chatSession = model.startChat(
        history: chatHistory.isEmpty ? _getInitialMessages() : chatHistory);
  }

  Future<String> sendMessage(String userMessage) async {
    log(modelName);
    try {
      if (_isAskingWhoAmI(userMessage)) {
        final botResponse =
            "I am $botName, an AI assistant created by $creatorName. How can I assist you today?";
        _addMessage(isUser: false, text: botResponse);
        return botResponse;
      }

      // Add user message to chat history
      _addMessage(isUser: true, text: userMessage);

      // Send message and maintain chat context
      final response = await chatSession.sendMessage(Content.text(userMessage));

      if (response.text != null) {
        _addMessage(isUser: false, text: response.text!);
        HapticFeedback.lightImpact();
        return response.text!;
      } else {
        return "No response from Gemini.";
      }
    } catch (e) {
      return "Error: Something went wrong. Please try again. $e";
    }
  }

  /// Adds a message to chat history and updates session
  void _addMessage({required bool isUser, required String text}) {
    final newContent =
        isUser ? Content.text(text) : Content.model([TextPart(text)]);
    chatHistory.add(newContent);

    // Update chat session with history
    chatSession = model.startChat(history: chatHistory);
    log("Chat history updated: ${chatHistory.length} messages.");
  }

  /// Provides initial bot message
  static List<Content> _getInitialMessages() {
    return [
      Content.text("Hi!"),
      Content.model([
        TextPart(
            "Hello! I am Saraswati AI, created by Deependra Kashyap. How can I help you?")
      ]),
    ];
  }

  /// Checks if the user asks about bot identity
  bool _isAskingWhoAmI(String message) {
    final lowerMsg = message.toLowerCase();
    return lowerMsg.contains("who are you") ||
        lowerMsg.contains("what's your name") ||
        lowerMsg.contains("who is this") ||
        lowerMsg.contains("tell me about yourself");
  }
}
