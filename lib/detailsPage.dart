import 'package:flutter/material.dart';
import 'package:flutter_project_melanie/Venue.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Image.dart';
import 'Comment.dart';
import 'env.dart';

import "mapPage.dart";

class DetailScreen extends StatelessWidget {
  // This widget is the root of your application.
  Venue venue;

  DetailScreen({Key key, this.venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.venue.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailsPage(title: this.venue.name, venue: this.venue),
    );
  }
}

class DetailsPage extends StatefulWidget {
  final String title;
  final Venue venue;

  DetailsPage({Key key, this.title, this.venue}) : super(key: key);

  @override
  State<DetailsPage> createState() {
    return _MyDetailsPageState(this.venue);
  }
}

class _MyDetailsPageState extends State<DetailsPage> {
  final Venue venue;

  _MyDetailsPageState(this.venue);

  List<Item> _images = new List();

  List<Comment> _comments = new List();

  var isLoadingImages = false;
  var isLoadingComments = false;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _fetchComments();
    print(this._images);
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(venue.name),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(venue.categories[0].icon.prefix +
              "32" +
              venue.categories[0].icon.suffix),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(venue.name),
            Text(venue.location.getFormattedAddress()),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      venue.categories[0].icon.prefix +
                          "44" +
                          venue.categories[0].icon.suffix),
                ),
                Text(venue.categories[0].shortName)
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text("Some pictures : "),
                  isLoadingImages
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _images.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(_images[index].prefix +
                                "300x500" +
                                _images[index].suffix);
                            return Container(
                                height: 520,
                                child: Image.network(_images[index].prefix +
                                    "300x500" +
                                    _images[index].suffix));
                          },
                        ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("Some comments : "),
                  isLoadingComments
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(_comments[index].text);
                            return Text(_comments[index].user.firstName +
                                " " +
                                _comments[index].user.lastName +
                                ": " +
                                _comments[index].text);
                          },
                        ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("See the venue on Google Maps"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Maps(venue: this.venue),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Item>> _fetchImages() async {
    setState(() {
      isLoadingImages = true;
    });

    String venueId = this.venue.id;
    print(this.venue.id);
    final baseUrl = "https://api.foursquare.com/v2/venues/" +
        venueId +
        "/photos?&client_id=" +
        clientID +
        "&client_secret=" +
        clientSecret +
        "&v=20181231";

    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      JsonResponseImages jsonDataImages =
          JsonResponseImages.fromJson(json.decode(response.body));

      this._images = jsonDataImages.response.photos.getItems();
      print(jsonDataImages.response.photos);
      print(this._images[0].prefix);
      print(this._images.toString());

      setState(() {
        isLoadingImages = false;
      });
      return this._images;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<Comment>> _fetchComments() async {
    setState(() {
      isLoadingComments = true;
    });

    String venueId = this.venue.id;
    final baseUrl = "https://api.foursquare.com/v2/venues/" +
        venueId +
        "/tips?&client_id=" +
        clientID +
        "&client_secret=" +
        clientSecret +
        "&v=20181231&sort=recent&limit=10";

    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      JsonResponseComments jsonDataComments =
          JsonResponseComments.fromJson(json.decode(response.body));

      this._comments = jsonDataComments.response.tips.comments;
      print(this._comments);

      setState(() {
        isLoadingComments = false;
      });
      return this._comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
