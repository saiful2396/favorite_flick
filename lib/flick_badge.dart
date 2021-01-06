import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_flick/favoriteScreen.dart';
import 'package:flutter/material.dart';

class FlickBadge extends StatelessWidget {
  final String owner;
  final String ownerName;
  final Function onFavoriteChanged;
  final bool isFavorite;

  FlickBadge({
    this.owner,
    this.ownerName,
    this.isFavorite,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    String badgeUrl = "https://flickr.com/buddyicons/$owner.jpg";

    return Container (
        padding: EdgeInsets.all(10.0),
        color: Color.fromRGBO(0,0,0,0.4),
        width: double.infinity,
        child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: badgeUrl,
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(badgeUrl)
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(ownerName, style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FavoriteWidget(isFavorite: isFavorite, onFavoriteChanged: onFavoriteChanged)
                    ],
                  ),
                )
              ],
            ))
    );
  }
}
