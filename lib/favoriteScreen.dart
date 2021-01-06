import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {

  final void Function(bool isFavorite) onFavoriteChanged;
  final bool isFavorite;

  FavoriteWidget({Key key, this.isFavorite, this.onFavoriteChanged}) : super(key: key);

  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void toggleFavorite() {
    setState((){
      _isFavorite = !_isFavorite;
      widget.onFavoriteChanged(_isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(0.0),
      child: IconButton(
          icon: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.yellow[500],
          onPressed: toggleFavorite),
    );
  }
}