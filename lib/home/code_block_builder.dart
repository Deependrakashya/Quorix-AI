import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final String codeText = element.textContent;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[900], // Dark background for code block
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SelectableText(
              codeText,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.amber,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: IconButton(
            icon: const Icon(Icons.copy, size: 15, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: codeText));
              Get.snackbar(
                  backgroundColor: Colors.black,
                  icon: Icon(
                    Icons.code,
                    color: Colors.amber,
                    size: 30,
                  ),
                  'Code',
                  "Copied Successfully");
            },
          ),
        ),
      ],
    );
  }
}
