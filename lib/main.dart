import 'package:flutter/material.dart';
import 'package:flutter_project_melanie/Venue.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'env.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter project Mélanie'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _location = TextEditingController();
  TextEditingController _type = TextEditingController();

  List<Venue> _suggestions = new List();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _location,
                  decoration: InputDecoration(
                      labelText: 'Enter a location'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _type,
                  decoration: InputDecoration(
                      labelText: 'Enter a type of location'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a type of venues';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(_location.text);
                        _suggestions = await _fetchVenues(_location.text);
                        for (Venue v in _suggestions) {
                          print(v.name);
                        }
                        print(_suggestions.length);
                      }
                    }, //n'affiche rien
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: new Text(_suggestions[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Future<List<Venue>> _fetchVenues(String location) async {
    setState(() {
      isLoading = true;
    });

    final baseUrl = "https://api.foursquare.com/v2/venues/search";
    final response = await http.get(
        baseUrl + "?client_id=" + clientID + "&client_secret=" + clientSecret +
            "&v=20181231&near=" + location);

    if (response.statusCode == 200) {
      JsonResponseVenues jsonAllDataResponse = JsonResponseVenues.fromJson(
          json.decode(response.body));
      List<Venue> _suggestions = jsonAllDataResponse.venues.getVenues();
      print(_suggestions);


      //_suggestions = (jsonAllVenues as Iterable<Venue>).map((data) => new Venue.fromJson(data));
      /*_suggestions = ["a","b","c"];*/
      /*_suggestions = (json.decode(response.body) as List).map((data) => new Venues.fromJson(data))*/
      /*.toList();*/
      setState(() {
        isLoading = false;
      });
      return _suggestions;
    } else {
      print("error");
      throw Exception('Failed to load photos');
    }
  }
}



