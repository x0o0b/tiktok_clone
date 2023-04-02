import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/flash_button.dart';

final List<dynamic> flashButtons = [
  {
    "flashMode": FlashMode.off,
    "icon": Icons.flash_off_rounded,
  },
  {
    "flashMode": FlashMode.always,
    "icon": Icons.flash_on_rounded,
  },
  {
    "flashMode": FlashMode.auto,
    "icon": Icons.flash_auto_rounded,
  },
  {
    "flashMode": FlashMode.torch,
    "icon": Icons.flashlight_off_rounded,
  },
];

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermissions = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermissions = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _deniedPermissions
                    ? [
                        const Text("권한이 허용되지 않았습니다"),
                      ]
                    : [
                        const Text(
                          "Initializing...",
                          style: TextStyle(
                              color: Colors.white, fontSize: Sizes.size20),
                        ),
                        Gaps.v20,
                        const CircularProgressIndicator.adaptive()
                      ],
              )
            : Stack(
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: Sizes.size48,
                    right: Sizes.size10,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfieMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        for (var flashButton in flashButtons)
                          Row(
                            children: [
                              Gaps.v10,
                              FlashButton(
                                flashMode: _flashMode,
                                setFlashMode: _setFlashMode,
                                newFlashMode: flashButton["flashMode"],
                                icon: flashButton["icon"],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
