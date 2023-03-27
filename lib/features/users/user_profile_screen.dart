import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widget/info_profile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("Hoseon"),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const FaIcon(
            //     FontAwesomeIcons.bell,
            //   ),
            // ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/102401551?v=4",
                ),
                child: Text("hoseon"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@Hoseen",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16,
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
              Gaps.v24,
              SizedBox(
                height: Sizes.size48,
                child: Row(
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
