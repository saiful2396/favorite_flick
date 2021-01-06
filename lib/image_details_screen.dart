import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'flick_photo.dart';
import 'image_detail_tab_item.dart';

class ImageDetailsScreen extends StatefulWidget {

  final FlickPhoto photo;

  ImageDetailsScreen({this.photo});

  @override
  _ImageDetailsScreenState createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    FlickPhoto photo = widget.photo;
    String farm = photo.farm.toString();
    String secret = photo.secret;
    String server = photo.server;

    String photoUrl = "https://farm$farm.staticflickr.com/$server/${photo.id}_$secret.jpg";

    String badgeUrl = "https://flickr.com/buddyicons/${photo.owner}.jpg";

    return Scaffold(
        appBar: AppBar(
            title: Text('Image Details')
        ),
        body: ListView(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        child: Hero(
                            tag: photo.title,
                            child: CachedNetworkImage(
                                imageUrl: photoUrl,
                                height: 240.0,
                                width: double.infinity,
                                fit: BoxFit.cover)
                        )
                    ),
                    Container(
                      height: 40.0,
                    )
                  ],
                ),

                Hero(
                  tag: badgeUrl,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, bottom: 0.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(badgeUrl)
                          )
                      )
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Text(photo.title, style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ))
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(0.3)
                  },
                  children: [
                    TableRow(
                        children: [
                          ImageDetailsTableItem("By"),
                          ImageDetailsTableItem(photo.owner, isBold: true)
                        ]),
                    TableRow(
                        children: [
                          ImageDetailsTableItem("Date Taken"),
                          //ImageDetailsTableItem(DateFormat("d MMMM, yyyy").format(photo.dateTaken), isBold: true)
                        ]),
                    TableRow(
                        children: [
                          ImageDetailsTableItem("Viewed"),
                          ImageDetailsTableItem(photo.farm.toString(), isBold: true)
                        ]),
                  ],
                )
            )
          ],
        )
    );
  }
}