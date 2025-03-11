class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String uploadTime;
  final String views;
  final String author;
  final String videoUrl;
  final String description;
  final String subscriber;
  final bool isLive;
  bool isLiked;
  bool isSubscribed;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadTime,
    required this.views,
    required this.author,
    required this.videoUrl,
    required this.description,
    required this.subscriber,
    required this.isLive,
    this.isLiked = false,
    this.isSubscribed = false,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration'],
      uploadTime: json['uploadTime'],
      views: json['views'],
      author: json['author'],
      videoUrl: json['videoUrl'],
      description: json['description'],
      subscriber: json['subscriber'],
      isLive: json['isLive'],
    );
  }
}