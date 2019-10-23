import 'package:flutter/material.dart';
import 'package:flutter_project_melanie/Venue.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Category.dart';
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
  List<Category> _categories = new List();
  var isLoading = false;
  var isLoadingCategories = false;


  Category _currentCategory;
  String _currentCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }


  void changedDropDownItem(Category selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
      _currentCategoryId = selectedCategory.id;
    });
  }



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
                DropdownButton<Category>(
                  value: _currentCategory,
                  items: _categories.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item.pluralName),
                      value: item,
                    );
                  }).toList(),
                  onChanged: changedDropDownItem,
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
                print(_suggestions[index].categories[0].icon.prefix);
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: new Text(_suggestions[index].name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        _suggestions[index].categories[0].icon.prefix + "44" +
                            _suggestions[index].categories[0].icon.suffix),
                  ),
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
            "&v=20181231&near=" + location + "&categoryId=" +
            _currentCategoryId);

    if (response.statusCode == 200) {
      JsonResponseVenues jsonAllDataResponse = JsonResponseVenues.fromJson(
          json.decode(response.body));
      List<Venue> _suggestions = jsonAllDataResponse.venues.getVenues();
      print(_suggestions);

      setState(() {
        isLoading = false;
      });
      return _suggestions;
    } else {
      print("error");
      throw Exception('Failed to load venues');
    }
  }

  Future<List<Category>> _fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });
    final baseUrl = "https://api.foursquare.com/v2/venues/categories";
    final response = await http.get(
        baseUrl + "?client_id=" + clientID + "&client_secret=" + clientSecret +
            "&v=20181231");

    if (response.statusCode == 200) {
      JsonResponseCategories jsonAllDataResponse = JsonResponseCategories
          .fromJson(
          json.decode(response.body));
      _categories = jsonAllDataResponse.categories.getCategories();
      print(_categories);


      _currentCategory = _categories[0];
      _currentCategoryId = _currentCategory.id;

      setState(() {
        isLoadingCategories = false;
      });

      return _categories;
    } else {
      print("error");
      throw Exception('Failed to load categories');
    }
  }

}





