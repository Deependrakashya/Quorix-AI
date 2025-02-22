import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:meta_mind/home/code_block_builder.dart';
import 'package:meta_mind/home/controller.dart';

Widget CustomDrawer(BuildContext context) {
  return Drawer(
    width: MediaQuery.of(context).size.width * .7,
    shape: const Border(top: BorderSide.none, bottom: BorderSide.none),
    child: SafeArea(
      child: Container(
        alignment: Alignment.topRight,
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              color: const Color.fromARGB(98, 138, 137, 137),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              child: const Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                "Drawer Item 1Drawer Item 1Drawer Item 1Drawer Item 1",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget SuggestionButton({
  required String title,
  required Controller controller,
}) {
  return InkWell(
    onTap: () {
      controller.textEditingController.text = title;
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget ChatMessage({
  required bool isUser,
  required BuildContext context,
  required String message,
}) {
  return Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85, // Limit width
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isUser ? Colors.black : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
          bottomRight: isUser ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: isUser
          ? SelectableText(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            )
          : MarkdownBody(
              selectable: false,
              data: message.toString(),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 16),
                h1: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                h2: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builders: {'code': CodeBlockBuilder()},
            ),
    ),
  );
}

Widget ReportMessage({required BuildContext context}) {
  return Container(
    height: MediaQuery.of(context).size.height * .5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          "Provide FeedBack",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Provide Your FeedBack',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (e) {}),
            Text('This is harmful/unsafe'),
          ],
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (e) {}),
            Text('This is not true'),
          ],
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (e) {}),
            Text('This is Helpful'),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(5),
            child: TextButton(
              onPressed: () {},
              child: Text('Submint', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}

Widget cusotmDropDownButton({required Controller controller}) {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      icon: const Icon(
        Icons.touch_app_outlined,
        color: Colors.red,
        size: 20,
      ),
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
      ),
      hint: const Text(
        'Deep Mind AI',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      isExpanded: true, // Allows content to fit properly
      iconSize: 16, // Reduce the icon size for a smaller button
      items: [
        'AI Models  🚀 ',
        'Good Strength & Speed',
        'Fast inference & extended thinking',
        'Speed and efficiency',
        'Newer generation',
        'High Reasoning & Adaptability',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ), // Smaller text
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        switch (newValue) {
          case "Good Strength & Speed":
            controller.aiModel.value = 'gemini-2.0-flash-lite-preview-02-05';
            break;
          case "Fast inference & extended thinking":
            controller.aiModel.value = 'gemini-2.0-flash-thinking-exp-01-21';
            break;
          case "Speed and efficiency":
            controller.aiModel.value = 'gemini-2.0-flash';
            break;
          case "Newer generation":
            controller.aiModel.value = 'gemini-1.5-flash-8';
            break;
          case "High Reasoning & Adaptability":
            controller.aiModel.value = 'gemma-2-27b-it';
            break;
          default:
            controller.aiModel.value = 'gemini-2.0-flash-lite-preview-02-05';
        }

        if (newValue != 'AI Models  🚀 ') {
          Get.snackbar(
            margin: const EdgeInsets.all(20),
            reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
            forwardAnimationCurve: Curves.easeOutCirc,
            duration: const Duration(seconds: 5),
            icon: Icon(Icons.rocket_launch_outlined),
            colorText: Colors.amber,
            newValue.toString(),
            "Model Changed Successfully",
          );
        }
      },
    ),
  );
}
