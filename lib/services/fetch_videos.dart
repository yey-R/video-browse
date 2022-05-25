import 'package:firebase_database/firebase_database.dart';
import 'package:video_browse/models/user.dart';
import 'package:video_browse/models/video_info.dart';

class FetchVideos {
  static final FetchVideos _fetchVideos = FetchVideos._internal();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final List<VideoInfo> _videoList = <VideoInfo>[];
  dynamic _value;

  factory FetchVideos() {
    return _fetchVideos;
  }

  FetchVideos._internal();

  Future<void> fetchVideos() async {
    final snapshot = await _dbRef.child('videos').get();
    if (snapshot.exists) {
      _value = snapshot.value!;
    }
  }

  Future<void> setVideos() async {
    if (_value == null) await fetchVideos();
    if (_value == null) return;
    _videoList.clear();
    for (var key in _value.keys) {
      if (_value[key] == null) continue;
      Set<String> views = Set.from(_value[key]["view"]);
      Set<String> likes = Set.from(_value[key]["likes"]);

      VideoInfo video = VideoInfo(
        name: _value[key]["title"],
        description: _value[key]["desc"],
        category: _value[key]["category"],
        user: User(_value[key]["user"]),
        duration: _value[key]["duration"],
        view: views,
        likes: likes,
        viewLastDay: _value[key]["viewLastDay"],
        uploadDate: _value[key]["uploadDate"],
        commentToggle: _value[key]["commentToggle"],
        videoURL: _value[key]["linkToVideo"],
        thumbnailURL: _value[key]["linkToThumbnail"],
      );
      _videoList.add(video);
    }
  }

  List<VideoInfo> getVideos() {
    return _videoList;
  }
}
