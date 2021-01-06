import 'flick_photo_list.dart';


class FlickResult {
  FlickPhotoList photos;
  String stat;

  FlickResult({
    this.photos,
    this.stat
  });

  factory FlickResult.fromJson(Map<String, dynamic> parsedJson) {

    var photoList = FlickPhotoList.fromJson(parsedJson['photos']);

    return FlickResult(
        photos: photoList,
        stat: parsedJson['stat']
    );
  }
}