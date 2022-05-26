import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as p;

class UploadVideo {
  static final UploadVideo _uploadVideo = UploadVideo._internal();
  final ImagePicker _picker = ImagePicker();
  final Reference _storageRef = FirebaseStorage.instance.ref();
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;
  dynamic _pickedFile;
  dynamic _filePath;

  factory UploadVideo() {
    return _uploadVideo;
  }

  UploadVideo._internal();

  Future pickVideo() async {
    try {
      _pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      _filePath = _pickedFile.path;
    } catch (e) {
      return;
    }
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
    await createMetadata(
      info,
      ref,
      thumbnailLink,
    );
  }

  Future<void> createMetadata(VideoInfo info, ref, thumbnail) async {
    DatabaseReference dbRef = _dbInstance.ref("videos/${info.getID()}");
    String videoURL = await ref.getDownloadURL();

    await dbRef.set(
      {
        "title": info.getName(),
        "category": info.getCategory(),
        "desc": info.getDesc(),
        "user": FetchUser().getCurrentUserUID(),
        "duration": info.getDuration(),
        "view": info.getViewData(),
        "likes": info.getLikeData(),
        "uploadDate": info.getUploadDate(),
        "commentToggle": info.getCommentToggle(),
        "linkToVideo": videoURL,
        "linkToThumbnail": thumbnail,
      },
    );
    info.setURL(videoURL);
    info.setThumbnail(thumbnail);
    FetchVideos().updateVideoList(info);
  }

  Future<void> updateMetadata(VideoInfo info) async {
    DatabaseReference dbRef = _dbInstance.ref("videos/${info.getID()}");
    await dbRef.set(
      {
        "title": info.getName(),
        "category": info.getCategory(),
        "desc": info.getDesc(),
        "user": info.getOwner().getUID(),
        "duration": info.getDuration(),
        "view": info.getViewData(),
        "likes": info.getLikeData(),
        "uploadDate": info.getUploadDate(),
        "commentToggle": info.getCommentToggle(),
        "linkToVideo": info.getURL(),
        "linkToThumbnail": info.getThumbnail(),
      },
    );
    FetchVideos().updateVideoList(info);
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
