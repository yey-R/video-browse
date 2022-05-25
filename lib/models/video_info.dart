import 'dart:math';
import 'package:video_browse/models/user.dart';
import 'comment.dart';

class VideoInfo {
  final String name;
  final String description;
  final String category;
  final User user;
  final int duration;
  final Set<String> view;
  final Set<String> likes;
  dynamic viewLastDay;
  dynamic uploadDate;
  final bool commentToggle;
  dynamic videoURL;
  dynamic thumbnailURL;
  final List<Comment> comments = <Comment>[];
  String id = "";

  VideoInfo({
    required this.name,
    required this.description,
    required this.category,
    required this.user,
    required this.duration,
    required this.commentToggle,
    required this.view,
    required this.likes,
    required this.viewLastDay,
    required this.uploadDate,
    required this.videoURL,
    required this.thumbnailURL,
  }) {
    generateID();
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }

  void increaseView(String uid) {
    view.add(uid);
  }

  void setLike(String uid) {
    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }
  }

  List<Comment> getComments() {
    return comments;
  }

  String getURL() {
    return videoURL;
  }

  String getThumbnail() {
    return thumbnailURL;
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
    return view.length;
  }

  int getLikes() {
    return likes.length;
  }

  int getViewLastDay() {
    return viewLastDay;
  }

  int getUploadDate() {
    return uploadDate;
  }

  bool getCommentToggle() {
    return commentToggle;
  }
}
