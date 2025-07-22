// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';

// class StreamPlayerPage extends StatefulWidget {
//   const StreamPlayerPage({super.key, required this.streamUrl, this.onError});
//   final String streamUrl;
//   final Function(String)? onError;

//   @override
//   State<StreamPlayerPage> createState() => _StreamPlayerPageState();
// }

// class _StreamPlayerPageState extends State<StreamPlayerPage> {
//   late BetterPlayerController _betterPlayerController;
//   bool _isLoading = true;
//   bool _hasError = false;
//   int _retryCount = 0;
//   static const int _maxRetries = 3;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     setState(() {
//       _isLoading = true;
//       _hasError = false;
//     });

//     try {
//       BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.streamUrl,
//         liveStream: true,
//         videoFormat: BetterPlayerVideoFormat.hls,
//         asmsTrackNames: const ["Auto", "Low", "Medium", "High"],
//         cacheConfiguration: const BetterPlayerCacheConfiguration(
//           useCache: false, // Disable caching for live streams
//         ),
//         notificationConfiguration: const BetterPlayerNotificationConfiguration(
//           showNotification: false,
//         ),
//       );

//       _betterPlayerController = BetterPlayerController(
//         BetterPlayerConfiguration(
//           autoPlay: true,
//           fit: BoxFit.contain,
//           controlsConfiguration: const BetterPlayerControlsConfiguration(
//             enableFullscreen: true,
//             enablePlayPause: true,
//             enableMute: true,
//             enableProgressBar: true,
//             enableProgressText: true,
//             enableSkips: false,
//             loadingWidget: CircularProgressIndicator(),
//             liveTextColor: Colors.red,
//             playerTheme: BetterPlayerTheme.material,
//           ),
//           aspectRatio: 16 / 9,
//           handleLifecycle: true,
//           autoDetectFullscreenDeviceOrientation: true,
//           errorBuilder: (context, errorMessage) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 42,
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Error loading stream",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(height: 8),
//                   if (_retryCount < _maxRetries)
//                     ElevatedButton(
//                       onPressed: _retryPlayback,
//                       child: const Text("Retry"),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//         betterPlayerDataSource: betterPlayerDataSource,
//       );

//       _betterPlayerController.addEventsListener((event) {
//         if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//           setState(() {
//             _isLoading = false;
//           });
//         } else if (event.betterPlayerEventType ==
//             BetterPlayerEventType.exception) {
//           debugPrint("Player error: ${event.parameters}");
//           setState(() {
//             _hasError = true;
//             _isLoading = false;
//           });

//           if (widget.onError != null) {
//             widget.onError!("Failed to load stream: ${event.parameters}");
//           }

//           if (_retryCount < _maxRetries) {
//             _retryPlayback();
//           }
//         }
//       });
//     } catch (e) {
//       debugPrint("Error initializing player: $e");
//       setState(() {
//         _hasError = true;
//         _isLoading = false;
//       });

//       if (widget.onError != null) {
//         widget.onError!("Error initializing player: $e");
//       }
//     }
//   }

//   void _retryPlayback() async {
//     _retryCount++;
//     debugPrint("Retrying playback, attempt $_retryCount");
//     await Future.delayed(const Duration(seconds: 2));
//     _initializePlayer();
//   }

//   @override
//   void dispose() {
//     _betterPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     if (_hasError) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.red, size: 42),
//             const SizedBox(height: 12),
//             const Text(
//               "Error loading stream",
//               style: TextStyle(color: Colors.white),
//             ),
//             const SizedBox(height: 8),
//             if (_retryCount < _maxRetries)
//               ElevatedButton(
//                 onPressed: _retryPlayback,
//                 child: const Text("Retry"),
//               ),
//           ],
//         ),
//       );
//     }

//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: BetterPlayer(controller: _betterPlayerController),
//     );
//   }
// }
