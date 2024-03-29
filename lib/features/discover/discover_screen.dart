import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  late final TabController _tabController;

  String _searchtext = "";

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _onClearTab() {
    _textEditingController.clear();
  }

  void _onStopSearch() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      setState(() {
        _searchtext = _textEditingController.text;
      });
    });

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(
      () {
        if (_tabController.indexIsChanging) {
          _onStopSearch;
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                height: Sizes.size40,
                constraints: const BoxConstraints(
                  maxWidth: Breakpoints.sm,
                ),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDarkmode(context)
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: isDarkmode(context)
                              ? Colors.grey.shade500
                              : Colors.black,
                          size: Sizes.size20,
                        ),
                      ],
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_searchtext.isNotEmpty)
                          GestureDetector(
                            onTap: _onClearTab,
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: isDarkmode(context)
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade600,
                              size: Sizes.size20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: _onStopSearch,
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              FaIcon(
                FontAwesomeIcons.chevronLeft,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: const EdgeInsets.only(
              right: Sizes.size12,
            ),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                FaIcon(
                  FontAwesomeIcons.sliders,
                ),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          isScrollable: true,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16,
          ),
          tabs: [
            for (var tab in tabs)
              Tab(
                text: tab,
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: 20,
            padding: const EdgeInsets.all(
              Sizes.size6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > Breakpoints.lg ? 5 : 2,
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/kayoko.jpeg",
                        image:
                            "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "${constraints.maxWidth} This is a very long caption for my tiktok that im upload just now currently",
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.v5,
                  if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
                    DefaultTextStyle(
                      style: TextStyle(
                        color: isDarkmode(context)
                            ? Colors.grey.shade300
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/102401551?v=4",
                            ),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "User_sidfo_Sdfdsno",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size24,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
