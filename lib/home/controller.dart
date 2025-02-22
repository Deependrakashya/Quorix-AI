import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_mind/home/data/model/qnAModel.dart';
import 'package:meta_mind/home/domain/repo/home_repo.dart';

class Controller extends GetxController {
  RxBool newScreen = true.obs;
  RxString aiModel = 'gemini-2.0-flash-lite-preview-02-05'.obs;
  RxString response = ''.obs;
  var qnAList = <QnAModel>[].obs;
  TextEditingController textEditingController = TextEditingController();
  int id = 0;
  RxBool isloading = false.obs;
  late AIChatSession aiChatSession;

  void initializeChatSession() {
    log("ai chatSession initialed");
    aiChatSession = AIChatSession(
      "AIzaSyBjwEg4HBG60ZZdtJsbaZ5-_XkGk5-F2kc",
      aiModel.value,
    );
  }

  void newScreenClear() {
    textEditingController.clear();
    qnAList.clear();
    aiChatSession.chatHistory.clear();

    newScreen.value = true;
  }

  void sendQuery() async {
    newScreen.value = false;

    if (textEditingController.text.isNotEmpty) {
      String question = textEditingController.text;
      textEditingController.clear();
      isloading.value = true;

      qnAList.add(QnAModel(id: id, ques: question, reply: ""));

      final data = await aiChatSession.sendMessage(question);
      log(aiModel.toString());

      // Find and update the reply for the corresponding question
      int index = qnAList.indexWhere((item) => item.id == id);
      if (index != -1) {
        qnAList[index] = QnAModel(id: id, ques: question, reply: data);
        // log(data);
      }

      id++; // Increment ID after adding
      if (data.isNotEmpty) {
        isloading.value = false;

        newScreen.value = false;
        response.value = data;
      }
    }
  }
}
