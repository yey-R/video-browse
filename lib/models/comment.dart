import 'package:video_browse/models/user.dart';

class Comment {
  final User _owner;
  final String _comment;
  int date = DateTime.now().millisecondsSinceEpoch;

  Comment(
    this._owner,
    this._comment,
  );

  User getOwner() {
    return _owner;
  }

  String getComment() {
    return _comment;
  }

  DateTime getDate() {
    return DateTime.fromMillisecondsSinceEpoch(date);
  }
}
