import 'package:flutter/material.dart';
import 'package:flutter_practical_18/ui/home/video_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/video_service_provider.dart';
import '../ui_component/video_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsyncValue = ref.watch(videosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VideoHub',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Notifications
            },
          ),
        ],
      ),
      body: videosAsyncValue.when(
        data: (videos) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return VideoCard(
                video: video,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoDetailScreen(video: video),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading videos: $error'),
        ),
      ),
    );
  }
}
