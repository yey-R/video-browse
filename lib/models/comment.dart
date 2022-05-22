import 'package:video_browse/models/user.dart';

class Comment {
  final User _owner;
  final String _comment;
  final int _like;
  final int _dislike;
  final int _commentDate;

  Comment(
    this._owner,
    this._comment,
    this._like,
    this._dislike,
    this._commentDate,
  );

  String getOwner() {
    return _owner.getUsername();
  }

  String getComment() {
    return _comment;
  }

  int getLike() {
    return _like;
  }

  int getDislike() {
    return _dislike;
  }

  int getCommentDate() {
    return _commentDate;
  }
}
