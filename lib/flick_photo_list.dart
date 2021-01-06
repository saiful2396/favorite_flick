import 'flick_photo.dart';

class FlickPhotoList {
  int page;
  int pages;
  int perpage;
  int total;
  List<FlickPhoto> photo;

  FlickPhotoList({
    this.page,
    this.pages,
    this.perpage,
    this.total,
    this.photo
  });

  factory FlickPhotoList.fromJson(Map<String, dynamic> parsedJson) {

    var list = parsedJson['photo'] as List;
    List<FlickPhoto> photoList = list.map((i) => FlickPhoto.fromJson(i)).toList();

    return FlickPhotoList(
        page: parsedJson['page'],
        pages: parsedJson['pages'],
        perpage: parsedJson['perpage'],
        total: parsedJson['total'],
        photo: photoList);
  }
}