import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saraswati_ai/home/controller.dart';
import 'package:saraswati_ai/home/widgets.dart';

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
    return Theme(
      data: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            side: BorderSide(
              color: Colors.black, // Set your border color
              width: 1.0, // Set your desired border width
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
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
                              color: Colors.white,
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
                                color: Colors.white,
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
                                                return Container(
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
                                                              backgroundColor:
                                                                  Colors.black,
                                                              "Text Copied Successfully",
                                                              icon: Icon(
                                                                Icons
                                                                    .paste_outlined,
                                                                color: Colors
                                                                    .amber,
                                                                size: 30,
                                                              ),
                                                              colorText:
                                                                  Colors.amber,
                                                              "");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
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
                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textEditingController,
                      autofocus: true,
                      maxLines: null, // Expands vertically as you type
                      minLines: 1, // Starts with one line
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: 'Chat with Saraswati AI',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                      ),
                    ),
                  ),
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        controller.isloading.value
                            ? null
                            : controller.sendQuery();
                      },
                      icon: Icon(
                        controller.isloading.value
                            ? Icons.search_off
                            : CupertinoIcons.arrow_up_circle_fill,
                        size: 30,
                        color: controller.isloading.value
                            ? Colors.grey
                            : Colors.black,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
