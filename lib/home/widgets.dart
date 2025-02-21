import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:meta_mind/home/code_block_builder.dart';
import 'package:meta_mind/home/controller.dart';

Widget CustomDrawer(BuildContext context) {
  return Drawer(
    width: MediaQuery.of(context).size.width * .7,
    shape: const Border(top: BorderSide.none, bottom: BorderSide.none),
    child: SafeArea(
      child: Container(
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                    color: const Color.fromARGB(98, 138, 137, 137),
                    padding: const EdgeInsets.all(5),
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    child: const Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Drawer Item 1Drawer Item 1Drawer Item 1Drawer Item 1",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ));
              })),
    ),
  );
}

Widget SuggestionButton(
    {required String title, required Controller controller}) {
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                selectable: true,
                data: message.toString(),
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 16),
                  h1: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  h2: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                builders: {
                    'code': CodeBlockBuilder(),
                  }),
      ));
}
