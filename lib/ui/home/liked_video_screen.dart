import 'package:flutter/material.dart';
import 'package:flutter_practical_18/ui/home/video_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/video.dart';
import '../../data/repositories/video_service_provider.dart';

class LikedVideosScreen extends ConsumerWidget {
  const LikedVideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedVideos = ref.watch(likedVideosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liked Videos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: likedVideos.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No liked videos yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Your liked videos will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: likedVideos.length,
        itemBuilder: (context, index) {
          final video = likedVideos[index];
          return Dismissible(
            key: Key(video.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              ref.read(likedVideosProvider.notifier).removeLike(video.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${video.title} removed from likes'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      ref.read(likedVideosProvider.notifier).toggleLike(video);
                    },
                  ),
                ),
              );
            },
            child: LikedVideoCard(
              video: video,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoDetailScreen(video: video),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LikedVideoCard extends StatelessWidget {
  final Video video;
  final VoidCallback onTap;

  const LikedVideoCard({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    video.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.author,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      '${video.views} views',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}