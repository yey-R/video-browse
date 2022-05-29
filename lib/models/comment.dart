import 'package:video_browse/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  String getDate() {
    final upload = DateTime.fromMillisecondsSinceEpoch(date);
    return timeago.format(upload);
  }
}
