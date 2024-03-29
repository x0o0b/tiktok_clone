import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

import '../../../../constants/breakpoints.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();

    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            height: size.height * 0.75,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes.size16,
              ),
            ),
            child: Scaffold(
              backgroundColor: isDarkmode(context) ? null : Colors.grey.shade50,
              appBar: AppBar(
                backgroundColor:
                    isDarkmode(context) ? null : Colors.grey.shade50,
                automaticallyImplyLeading: false,
                title: const Text("23223 Comments"),
                actions: [
                  IconButton(
                    onPressed: _onClosePressed,
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                  ),
                ],
              ),
              body: GestureDetector(
                onTap: _stopWriting,
                child: Container(
                  color:
                      isDarkmode(context) ? Colors.black : Colors.grey.shade100,
                  child: Stack(
                    children: [
                      Scrollbar(
                        controller: _scrollController,
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(
                            top: Sizes.size10,
                            bottom: Sizes.size96 + Sizes.size24,
                            right: Sizes.size16,
                            left: Sizes.size16,
                          ),
                          separatorBuilder: (context, index) => Gaps.v20,
                          itemCount: 10,
                          itemBuilder: (context, index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    Color.fromARGB(255, 220, 123, 155),
                                child: Text(
                                  "user",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Gaps.h10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "user",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: Sizes.size14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gaps.v3,
                                    const Text(
                                        "That's not it l've seen the same thing but also in a cave")
                                  ],
                                ),
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.grey.shade500,
                                    size: Sizes.size20,
                                  ),
                                  Gaps.v2,
                                  Text(
                                    "52.2K",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: isDarkmode(context)
                              ? Colors.grey.shade800
                              : Colors.white,
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: Breakpoints.sm,
                            ),
                            padding: const EdgeInsets.only(
                              left: Sizes.size16,
                              right: Sizes.size16,
                              top: Sizes.size10,
                              bottom: Sizes.size32,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey.shade500,
                                  foregroundColor: Colors.white,
                                  child: const Text("user"),
                                ),
                                Gaps.h10,
                                Flexible(
                                  child: SizedBox(
                                    height: Sizes.size44,
                                    child: TextField(
                                      onTap: _onStartWriting,
                                      expands: true,
                                      minLines: null,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      decoration: InputDecoration(
                                        hintText: "Write a comment...",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: isDarkmode(context)
                                            ? Colors.grey.shade700
                                            : Colors.grey.shade200,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: Sizes.size12,
                                          horizontal: Sizes.size10,
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            right: Sizes.size14,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.at,
                                                color: isDarkmode(context)
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade900,
                                              ),
                                              Gaps.h14,
                                              FaIcon(
                                                FontAwesomeIcons.gift,
                                                color: isDarkmode(context)
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade900,
                                              ),
                                              Gaps.h14,
                                              FaIcon(
                                                FontAwesomeIcons.faceSmile,
                                                color: isDarkmode(context)
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade900,
                                              ),
                                              Gaps.h14,
                                              if (_isWriting)
                                                GestureDetector(
                                                  onTap: _stopWriting,
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .circleArrowUp,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
