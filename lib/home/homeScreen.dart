import 'package:quorix_ai/home/controller.dart';
import 'package:quorix_ai/home/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller controller = Controller();

  double _inputHeight = 50; // Initial height

  @override
  void initState() {
    super.initState();
    controller.textEditingController.addListener(_updateInputHeight);
    controller.initializeChatSession();
  }

  void _updateInputHeight() {
    int lineCount =
        '\n'.allMatches(controller.textEditingController.text).length + 1;
    double newHeight = 50 + (lineCount * 20); // Adjust height per line
    setState(() {
      _inputHeight = newHeight.clamp(50, 200); // Limit max height
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          return Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                              )
                              //  IconButton(
                              //   icon: const Icon(Icons.align_horizontal_left_sharp),
                              //   onPressed: () {
                              //     // Scaffold.of(context).openDrawer();
                              //   },
                              // ),
                              );
                        },
                      ),
                      Center(
                        child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 150,
                            ), // Adjust max width as needed
                            child:
                                cusotmDropDownButton(controller: controller)),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.newScreenClear();
                        },
                        icon: const Icon(Icons.add_to_photos_outlined),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Expanded(
                    // Ensures it takes available space
                    child: controller.newScreen.value
                        ? Container(
                            color: Colors.black,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Use ListView instead of SingleChildScrollView
                                children: [
                                  const Center(
                                    child: Text(
                                      "Welcome ! \n How Can I Help You Today",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 9,
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      children: [
                                        SuggestionButton(
                                          title: 'Surprise Me With a Fact',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'Tell Me a Funny Story',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'Help Me To Write an Email',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'Tell Me a Joke',
                                          controller: controller,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Obx(
                            () => Container(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: controller.scrollController,
                                itemCount: controller.qnAList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final message = controller.qnAList[index];
                                  return Column(
                                    children: [
                                      ChatMessage(
                                        context: context,
                                        message: message.ques.toString(),
                                        isUser: true,
                                      ),
                                      InkWell(
                                        onLongPress: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SafeArea(
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.report,
                                                          color: Colors.red,
                                                        ),
                                                        title: Text(
                                                          "Report Message",
                                                        ),
                                                        onTap: () {
                                                          controller
                                                              .feedbackTextEditingController
                                                              .clear();
                                                          controller.isharmful
                                                              .value = false;
                                                          controller
                                                              .isnotHelpful
                                                              .value = false;
                                                          controller.isnotTrue
                                                              .value = false;
                                                          Get.dialog(
                                                            Dialog(
                                                              child: ReportMessage(
                                                                  context:
                                                                      context,
                                                                  controller:
                                                                      controller,
                                                                  message: message
                                                                      .reply
                                                                      .toString()),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.copy,
                                                          color: Colors.black,
                                                        ),
                                                        title: Text(
                                                          'Copy Message',
                                                        ),
                                                        onTap: () {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text: message
                                                                      .reply
                                                                      .toString()));
                                                          Get.snackbar(
                                                            "Text Copied Successfully", // Title
                                                            "", // Message (empty since title is the message)
                                                            backgroundColor:
                                                                Colors
                                                                    .grey
                                                                    .withValues(
                                                                        alpha:
                                                                            .4),
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP, // or SnackPosition.TOP
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        20),
                                                            borderRadius: 12,
                                                            icon: const Icon(
                                                              Icons
                                                                  .paste_outlined,
                                                              color:
                                                                  Colors.amber,
                                                              size: 30,
                                                            ),
                                                            titleText:
                                                                const Center(
                                                              child: Text(
                                                                "Text Copied Successfully",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            messageText:
                                                                const SizedBox
                                                                    .shrink(), // hide default message
                                                          );
                                                          HapticFeedback
                                                              .vibrate();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: ChatMessage(
                                          context: context,
                                          message: message.reply.toString(),
                                          isUser: false,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                  );
                }),
                const SizedBox(height: 80),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: .5),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.white.withOpacity(0.1), // subtle white shadow
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: controller.textEditingController,
                              autofocus: true,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Chat with Quorix AI',
                                hintStyle: TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 34, 33, 33),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                              ),
                            ),
                          ),
                          Obx(() {
                            return IconButton(
                              onPressed: controller.isloading.value
                                  ? null
                                  : controller.sendQuery,
                              icon: Icon(
                                controller.isloading.value
                                    ? Icons.hourglass_empty
                                    : CupertinoIcons.search,
                                size: 30,
                                color: controller.isloading.value
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // bottomSheet:
      // ),
    );
  }
}
