import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/view/widgets/flash_button.dart';

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
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _deniedPermissions = false;
  bool _isSelfieMode = false;
  late double _currentZoomLevel;
  late double _maxZoomLevel;
  late double _minZoomLevel;

  late FlashMode _flashMode;
  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 150,
    ),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (!_hasPermission) return;
  //   if (state == AppLifecycleState.inactive) {
  //     if (!_cameraController.value.isInitialized) return;
  //     _cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     initCamera();
  //     setState(() {});
  //   }
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

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

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
    _minZoomLevel = await _cameraController.getMinZoomLevel();
    _currentZoomLevel = (_maxZoomLevel + _minZoomLevel) / 5;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    final photosPermission = await Permission.photos.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    final photosDenied =
        photosPermission.isDenied || photosPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied && !photosDenied) {
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
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
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

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  void _zoomChange(DragUpdateDetails details) async {
    if (details.localPosition.dy >= 0) {
      if (_currentZoomLevel + (-details.localPosition.dy * 0.05) <
          _minZoomLevel) return;
      _cameraController
          .setZoomLevel(_currentZoomLevel + (-details.localPosition.dy * 0.05));
    }
    if (details.localPosition.dy < 0) {
      if (_currentZoomLevel + (-details.localPosition.dy * 0.005) >
          _maxZoomLevel) return;
      _cameraController.setZoomLevel(
          _currentZoomLevel + (-details.localPosition.dy * 0.005));
    }
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
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size48,
                    left: Sizes.size10,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
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
                              Gaps.v60,
                              FlashButton(
                                flashMode: _flashMode,
                                setFlashMode: _setFlashMode,
                                newFlashMode: flashButton["flashMode"],
                                icon: flashButton["icon"],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onPanUpdate: (details) => _zoomChange,
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade500,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
