import 'flick_photo.dart';


class FlickFavorites {
  List favorites = [];

  void addFavorite(FlickPhoto photo) {
    favorites.add(photo);
  }

  void removeFavorite(FlickPhoto photo) {
    favorites.remove(photo);
  }

  bool isFavorite(FlickPhoto photo) {
    return favorites.contains(photo);
  }
}