import 'dart:math';
import 'package:video_browse/models/user.dart';
import 'comment.dart';

class VideoInfo {
  final String name;
  final String description;
  final String category;
  final User user;
  final int duration;
  dynamic view;
  dynamic likes;
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

  String getOwner() {
    return user.getUsername();
  }

  int getDuration() {
    return duration;
  }

  int getView() {
    return view;
  }

  int getLikes() {
    return likes;
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
