import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_browse/firebase_options.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as p;

class UploadVideo {
  final ImagePicker _picker = ImagePicker();
  late Reference _storageRef;
  late FirebaseDatabase _dbInstance;
  dynamic _pickedFile;
  dynamic _filePath;

  UploadVideo() {
    setDatabase();
  }

  Future<void> setDatabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signInAnonymously();
    _storageRef = FirebaseStorage.instance.ref();
    _dbInstance = FirebaseDatabase.instance;
  }

  Future pickVideo() async {
    _pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    _filePath = _pickedFile.path;
  }

  Future<void> uploadVideo(VideoInfo info) async {
    File file = File(_filePath);

    final ref =
        _storageRef.child("videos/${info.getID()}${p.extension(_filePath)}");
    try {
      await ref.putFile(file);
      // ignore: empty_catches
    } on FirebaseException {}
    dynamic thumbnailLink = await createThumbnail(info);
    writeMetadata(
      info,
      ref,
      thumbnailLink,
    );
    await FetchVideos().fetchVideos();
    await FetchVideos().setVideos();
  }

  Future<void> writeMetadata(VideoInfo info, ref, thumbnail) async {
    DatabaseReference dbRef = _dbInstance.ref("videos/${info.getID()}");

    await dbRef.set(
      {
        "title": info.getName(),
        "category": info.getCategory(),
        "desc": info.getDesc(),
        "user": info.getOwner(),
        "duration": info.getDuration(),
        "view": 0,
        "likes": 0,
        "viewLastDay": 0,
        "uploadDate": DateTime.now().millisecondsSinceEpoch,
        "commentToggle": info.getCommentToggle(),
        "linkToVideo": await ref.getDownloadURL(),
        "linkToThumbnail": thumbnail,
        "comments": info.getComments(),
      },
    );
  }

  Future<String> createThumbnail(VideoInfo info) async {
    String? thumbnail = await VideoThumbnail.thumbnailFile(
      thumbnailPath: null,
      video: _filePath,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    File file = File(thumbnail!);
    final ref = _storageRef.child("thumbnails/${info.getID()}");
    await ref.putFile(file);
    file.delete();
    return await ref.getDownloadURL();
  }

  bool isFilePicked() {
    return _pickedFile == null;
  }
}
