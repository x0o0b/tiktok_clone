import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UserEditingScreen extends ConsumerStatefulWidget {
  const UserEditingScreen({
    super.key,
    required this.bio,
    required this.link,
    required this.name,
  });
  final String name;
  final String bio;
  final String link;

  @override
  ConsumerState<UserEditingScreen> createState() => _UserEditingScreenState();
}

class _UserEditingScreenState extends ConsumerState<UserEditingScreen> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.name);
  late final TextEditingController _bioController =
      TextEditingController(text: widget.bio);
  late final TextEditingController _linkController =
      TextEditingController(text: widget.link);

  @override
  void dispose() {
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _onUpdateProfilePressed() async {
    await ref.read(usersProvider.notifier).updateProfile(
          bio: _bioController.text,
          link: _linkController.text,
          name: _nameController.text,
        );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const Text(
                "Bio",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                maxLines: 4,
                maxLength: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                "Link",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              TextField(
                controller: _linkController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _onUpdateProfilePressed,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Update profile",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
