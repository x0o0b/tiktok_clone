import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final FlashMode flashMode;
  final Future<void> Function(FlashMode flashMode) setFlashMode;
  final FlashMode newFlashMode;
  final IconData icon;

  const FlashButton({
    super.key,
    required this.icon,
    required this.flashMode,
    required this.setFlashMode,
    required this.newFlashMode,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == newFlashMode ? Colors.amber.shade200 : Colors.white,
      onPressed: () => setFlashMode(newFlashMode),
      icon: Icon(
        icon,
      ),
    );
  }
}
