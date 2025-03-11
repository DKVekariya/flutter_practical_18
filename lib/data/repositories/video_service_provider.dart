import 'package:flutter_practical_18/data/repositories/video_servies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/video.dart';

final videoServiceProvider = Provider<ApiService>((ref) => ApiService());

final videosProvider = FutureProvider<List<Video>>((ref) async {
  final videoService = ref.watch(videoServiceProvider);
  return videoService.getVideos();
});

final likedVideosProvider = StateNotifierProvider<LikedVideosNotifier, List<Video>>((ref) {
  return LikedVideosNotifier();
});

class LikedVideosNotifier extends StateNotifier<List<Video>> {
  LikedVideosNotifier() : super([]);

  void toggleLike(Video video) {
    final isAlreadyLiked = state.any((v) => v.id == video.id);

    if (isAlreadyLiked) {
      state = state.where((v) => v.id != video.id).toList();
    } else {
      video.isLiked = true;
      state = [...state, video];
    }
  }

  void removeLike(String videoId) {
    state = state.where((v) => v.id != videoId).toList();
  }

  bool isLiked(String videoId) {
    return state.any((v) => v.id == videoId);
  }
}
