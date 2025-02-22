import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_mind/home/controller.dart';
import 'package:meta_mind/home/widgets.dart';

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
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.align_horizontal_left_sharp),
                            onPressed: () {
                              // Scaffold.of(context).openDrawer();
                            },
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 150,
                          ), // Adjust max width as needed
                          child: cusotmDropDownButton(controller: controller)),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.newScreenClear();
                      },
                      icon: const Icon(Icons.add_to_photos_outlined),
                    ),
                  ],
                ),
                Obx(() {
                  return Expanded(
                    // Ensures it takes available space
                    child: controller.newScreen.value
                        ? Container(
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
                                        MediaQuery.of(context).size.width * .75,
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      children: [
                                        SuggestionButton(
                                          title: 'Summarise',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'tell me a story',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'Help me to write an email ',
                                          controller: controller,
                                        ),
                                        SuggestionButton(
                                          title: 'tell me a joke in Hindi',
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
                            () => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.qnAList.length,
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
                                                mainAxisSize: MainAxisSize.min,
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
                                                      Navigator.pop(context);

                                                      Get.dialog(
                                                        Dialog(
                                                          child: ReportMessage(
                                                            context: context,
                                                          ),
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
                  );
                }),
                const SizedBox(height: 120),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
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
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Prevent overflow
                  children: [
                    SizedBox(
                      height: _inputHeight, // Dynamic height
                      child: TextField(
                        controller: controller.textEditingController,
                        autofocus: true,
                        maxLines: null, // Allow multi-line
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Chat with Meta Mind AI',
                        ),
                      ),
                    ),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_a_photo_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.isloading.value
                                  ? null
                                  : controller.sendQuery();
                            },
                            icon: Icon(
                              controller.isloading.value
                                  ? Icons.search_off
                                  : CupertinoIcons.arrow_up_circle_fill,
                              size: 35,
                              color: controller.isloading.value
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
