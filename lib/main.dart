import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'custom_route.dart';
import 'flick_result.dart';
import 'flick_photo.dart';
import 'flick_badge.dart';
import 'image_details_screen.dart';
import 'flick_favorite.dart';
//0ec6b5ff3cb3a29629361daf6ca66491

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FlickMainPage());
  }
}

class FlickMainPage extends StatefulWidget {
  FlickMainPage({Key key}) : super(key: key);

  FlickFavorites favorites = FlickFavorites();

  updateFavorite(FlickPhoto photo, bool isFavorite) {
    if (isFavorite) {
      favorites.addFavorite(photo);
    } else {
      favorites.removeFavorite(photo);
    }
  }

  @override
  _FlickMainPageState createState() => _FlickMainPageState();
}

class _FlickMainPageState extends State<FlickMainPage> {
  final String flickKey = "0ec6b5ff3cb3a29629361daf6ca66491";
  FlickResult flickData;
  int resultsCount = 0;
  int tabIndex = 0;
  String appBarTitle = "Flutter Flickr";

  @override
  void initState() {
    super.initState();

    loadFlickData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = createTabs();

    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: _children[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: tabIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites')
          ]),
    );
  }

  List<Widget> createTabs() {
    return [
      ListView.builder(
          key: PageStorageKey('myListView'),
          itemCount: resultsCount,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }),
      GridView.builder(
          key: PageStorageKey('myGridView'),
          itemCount: widget.favorites.favorites.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3/2,
          ),
          itemBuilder: (BuildContext context, int position) {
            return getItem(position);
          })
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      tabIndex = index;
      if (index == 0) {
        appBarTitle = "Flickr Interesting";
      } else {
        appBarTitle = "Favourites";
      }
    });
  }

  Widget getRow(int i) {
    FlickPhoto photo = flickData.photos.photo[i];
    String farm = photo.farm.toString();
    String secret = photo.secret;
    String server = photo.server;

    String photoUrl =
        "https://farm$farm.staticflickr.com/$server/${photo.id}_$secret.jpg";

    return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Hero(
                  tag: photo.title,
                  child: CachedNetworkImage(
                    //placeholder: Image.asset('images/placeholder-image.jpg'),
                    imageUrl: photoUrl,
                    height: 240.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              FlickBadge(
                  owner: photo.owner,
                  ownerName: photo.owner,
                  isFavorite: widget.favorites.isFavorite(photo),
                  onFavoriteChanged: (isFavorite) {
                    setState(() {
                      widget.updateFavorite(photo, isFavorite);
                    });
                  }),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            navigateToItem(context, photo);
          });
        });
  }

  navigateToItem(BuildContext context, FlickPhoto photo) {
    Navigator.push(context,
        CustomRoute(builder: (context) => ImageDetailsScreen(photo: photo)));
  }

  loadFlickData() async {
    String requestUrl =
        "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=" +
            flickKey +
            "&format=json&nojsoncallback=1&extras=owner_name,date_taken,tags,views";

    var file = await DefaultCacheManager().getSingleFile(requestUrl);

    String lines = await file.readAsString();

    setState(() {
      Map userMap = jsonDecode(lines);
      flickData = FlickResult.fromJson(userMap);
      resultsCount = flickData.photos.photo.length;
    });
  }

  Widget getItem(int itemNumber) {
    FlickPhoto photo = widget.favorites.favorites[itemNumber];
    String farm = photo.farm.toString();
    String secret = photo.secret;
    String server = photo.server;

    String photoUrl =
        "https://farm$farm.staticflickr.com/$server/${photo.id}_$secret.jpg";

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Card(
            elevation: 5.0,
            child: CachedNetworkImage(
              imageUrl: photoUrl,
              height: 240.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          FlickBadge(
            owner: photo.owner,
            ownerName: photo.owner,
            isFavorite: widget.favorites.isFavorite(photo),
            onFavoriteChanged: (isFavorite) {
              setState(
                () {
                  widget.updateFavorite(photo, isFavorite);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
