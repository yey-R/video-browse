import 'dart:math';
import 'package:video_browse/models/user.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/upload_video.dart';
import 'comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoInfo {
  final String name;
  final String description;
  final String category;
  final User user;
  final int duration;
  dynamic views;
  dynamic likes;
  dynamic uploadDate;
  final bool commentToggle;
  dynamic videoURL;
  dynamic thumbnailURL;
  final List<Comment> comments = <Comment>[];
  dynamic id;

  VideoInfo({
    required this.name,
    required this.description,
    required this.category,
    required this.user,
    required this.duration,
    required this.commentToggle,
    this.id,
    this.views,
    this.likes,
    this.uploadDate,
    this.videoURL,
    this.thumbnailURL,
  }) {
    id ?? generateID();
    if (views == null) {
      views = <String>{};
      views.add(FetchUser().uid);
    }
    likes ??= <String>{};
    uploadDate ??= DateTime.now().millisecondsSinceEpoch;
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }

  Future<void> updateView(String uid) async {
    if (!views.contains(uid)) {
      views.add(uid);
      await UploadVideo().updateMetadata(this);
    }
  }

  Future<void> updateLike(String uid) async {
    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }
    await UploadVideo().updateMetadata(this);
  }

  bool isLiked(String uid) {
    return likes.contains(uid);
  }

  List<Comment> getComments() {
    return comments;
  }

  String getURL() {
    return videoURL;
  }

  void setURL(String url) {
    videoURL = url;
  }

  String getThumbnail() {
    return thumbnailURL;
  }

  void setThumbnail(String url) {
    thumbnailURL = url;
  }

  void generateID() {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    id = List.generate(
      4,
      (index) => availableChars[random.nextInt(availableChars.length)],
    ).join();
  }

  String getID() {
    return id;
  }

  String getName() {
    return name;
  }

  String getDesc() {
    return description;
  }

  String getCategory() {
    return category;
  }

  User getOwner() {
    return user;
  }

  int getDuration() {
    return duration;
  }

  int getView() {
    return views.length;
  }

  int getLikes() {
    return likes.length;
  }

  int getUploadDate() {
    return uploadDate;
  }

  String getDate() {
    final upload = DateTime.fromMillisecondsSinceEpoch(uploadDate);
    return timeago.format(upload);
  }

  bool getCommentToggle() {
    return commentToggle;
  }

  dynamic getViewData() {
    if (views.isEmpty) return 0;
    List<String> temp = <String>[];
    for (String view in views) {
      temp.add(view);
    }
    return temp;
  }

  dynamic getLikeData() {
    if (likes.isEmpty) return 0;
    List<String> temp = <String>[];
    for (String like in likes) {
      temp.add(like);
    }
    return temp;
  }
}
