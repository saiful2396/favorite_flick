class FlickPhoto {
  String id;
  String owner;
  String secret;
  String server;
  int farm;
  String title;
  int ispublic;
  int isfriend;
  int isfamily;

  FlickPhoto({
    this.id,
    this.owner,
    this.secret,
    this.server,
    this.farm,
    this.title,
    this.ispublic,
    this.isfriend,
    this.isfamily
  });

  factory FlickPhoto.fromJson(Map<String, dynamic> parsedJson) {

    return FlickPhoto(
        id: parsedJson['id'],
        owner: parsedJson['owner'],
        secret: parsedJson['secret'],
        server: parsedJson['server'],
        farm: parsedJson['farm'],
        title: parsedJson['title'],
        ispublic: parsedJson['ispublic'],
        isfriend: parsedJson['isfriend'],
        isfamily: parsedJson['isfamily']
    );
  }
}