import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_videos.dart';

class RemoveVideo {
  static final RemoveVideo _removeVideo = RemoveVideo._internal();
  final Reference _storageRef = FirebaseStorage.instance.ref();
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;
  factory RemoveVideo() {
    return _removeVideo;
  }

  RemoveVideo._internal();

  Future<void> removeVideo(VideoInfo info) async {
    dynamic ref = _storageRef.child("videos/${info.getID()}");
    await ref.delete();
    ref = _storageRef.child("/thumbnails/${info.getID()}");
    await ref.delete();
    ref = _dbInstance.ref("videos/${info.getID()}");
    await ref.remove();
    update(info);
  }

  Future<void> update(VideoInfo info) async {
    FetchVideos().removeVideo(info);
  }
}
