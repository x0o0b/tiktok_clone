import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

import '../../constants/breakpoints.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: ListView(
            children: [
              // ValueListenableBuilder(
              //   valueListenable: darkMode,
              //   builder: (context, value, child) => SwitchListTile.adaptive(
              //     value: value,
              //     onChanged: (value) {
              //       darkMode.value = !darkMode.value;
              //     },
              //     title: Text("Toggle ${!value ? "Dark" : "light"} mode"),
              //     subtitle: const Text("Video will be muted by default."),
              //   ),
              // ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) => {
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
                },
                title: const Text("Mute video"),
                subtitle: const Text("Video will be muted by default"),
              ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).autoplay,
                onChanged: (value) => {
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
                },
                title: const Text("Autoplay"),
                subtitle: const Text("Video will start playing autoatically."),
              ),
              CheckboxListTile(
                activeColor: Colors.black,
                value: false,
                onChanged: (value) {},
                title: const Text("Marketing emails"),
                subtitle: const Text("We won't spam you."),
              ),
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  print(date);
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print(time);
                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                            appBarTheme: const AppBarTheme(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black)),
                        child: child!,
                      );
                    },
                  );
                  print(booking);
                },
                title: const Text("What is your birthday?"),
                subtitle: const Text("I need to know!"),
              ),
              ListTile(
                title: const Text("Log out (iOS)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Please don't go"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(authRepo).signOut();
                            context.go("/");
                          },
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (Android)"),
                textColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const FaIcon(
                        FontAwesomeIcons.skull,
                      ),
                      title: const Text("Are you sure?"),
                      content: const Text("Please don't go"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      message: const Text("Please doooooont gooooo"),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDefaultAction: true,
                          child: const Text("Not log out"),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(
                applicationVersion: "1.0",
                applicationLegalese: "Don't copy me.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
