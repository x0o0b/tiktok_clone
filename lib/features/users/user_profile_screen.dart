import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widget/avatar.dart';
import 'package:tiktok_clone/features/users/widget/info_profile.dart';
import 'package:tiktok_clone/features/users/widget/persistent_tab_bar.dart';

import '../../constants/breakpoints.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            if (width < Breakpoints.lg) ...[
                              Avatar(
                                name: data.name,
                                uid: data.uid,
                                hasAvatar: data.hasAvatar,
                              ),
                              Gaps.v10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "@${data.name}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.size18,
                                    ),
                                  ),
                                  Gaps.h5,
                                  FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    size: Sizes.size16,
                                    color: Colors.blue.shade500,
                                  ),
                                ],
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const InfoProfile(
                                    num: '843',
                                    text: 'Following',
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  const InfoProfile(
                                    num: '10M',
                                    text: 'Followers',
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  const InfoProfile(
                                    num: '324.3M',
                                    text: 'Likes',
                                  ),
                                ],
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(Sizes.size3),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Gaps.h4,
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          Sizes.size3,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.youtube,
                                        size: Sizes.size24,
                                      ),
                                    ),
                                  ),
                                  Gaps.h4,
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          Sizes.size4,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.caretDown,
                                        size: Sizes.size12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 80,
                                    foregroundImage: NetworkImage(
                                      "https://avatars.githubusercontent.com/u/102401551?v=4",
                                    ),
                                    child: Text("hoseon"),
                                  ),
                                  Gaps.h16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "@Hoseon",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: Sizes.size18,
                                            ),
                                          ),
                                          Gaps.h5,
                                          FaIcon(
                                            FontAwesomeIcons.solidCircleCheck,
                                            size: Sizes.size16,
                                            color: Colors.blue.shade500,
                                          ),
                                        ],
                                      ),
                                      Gaps.v16,
                                      SizedBox(
                                        height: Sizes.size48,
                                        child: Row(
                                          children: [
                                            const InfoProfile(
                                              num: '843',
                                              text: 'Following',
                                            ),
                                            VerticalDivider(
                                              width: Sizes.size32,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade300,
                                              indent: Sizes.size14,
                                              endIndent: Sizes.size14,
                                            ),
                                            const InfoProfile(
                                              num: '10M',
                                              text: 'Followers',
                                            ),
                                            VerticalDivider(
                                              width: Sizes.size32,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade300,
                                              indent: Sizes.size14,
                                              endIndent: Sizes.size14,
                                            ),
                                            const InfoProfile(
                                              num: '324.3M',
                                              text: 'Likes',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gaps.v14,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 180,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(Sizes.size3),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Gaps.h4,
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  Sizes.size3,
                                                ),
                                              ),
                                            ),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.youtube,
                                                size: Sizes.size24,
                                              ),
                                            ),
                                          ),
                                          Gaps.h4,
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  Sizes.size4,
                                                ),
                                              ),
                                            ),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.caretDown,
                                                size: Sizes.size12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+ I worder how it would looooook",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  "https://nomadcoders.co",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: PersistentTabBar(),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width > Breakpoints.lg ? 5 : 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 13,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 13,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: "assets/images/kayoko.jpeg",
                                    image:
                                        "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      Sizes.size2,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        FaIcon(
                                          Icons.play_arrow_outlined,
                                          color: Colors.white,
                                          size: Sizes.size18,
                                        ),
                                        Gaps.h3,
                                        Text(
                                          "61.2K",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Sizes.size12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text('Page two'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
