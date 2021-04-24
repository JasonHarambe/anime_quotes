import 'dart:convert';

import 'package:anime/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.amber[100]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<http.Response> _fetchAnime() async {
    final result =
        http.get(Uri.parse('https://animechan.vercel.app/api/random'));
    await Future.delayed(Duration(seconds: 1));
    _isPressed = false;
    _buttonClicked = false;
    return result;
  }

  bool _buttonClicked = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchAnime(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Map animeData;

          if (snapshot.hasData) {
            animeData = jsonDecode(snapshot.data.body);
          } else {
            return Loading();
          }
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .2),
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: BoxDecoration(
                        color: Colors.redAccent[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 5),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 15.0,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              animeData['anime'],
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              animeData['character'],
                              maxLines: 1,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              animeData['quote'],
                              maxLines: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  width: 120,
                  height: 50,
                  color: Colors.yellow,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4.0,
                      onPrimary: Colors.black87,
                      primary: _isPressed
                          ? Colors.blueGrey[300]
                          : Colors.blueAccent[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    onPressed: () {
                      if (!_isPressed) {
                        setState(() {
                          _buttonClicked = true;
                          _isPressed = true;
                        });
                      }
                    },
                    child: Text(
                      _buttonClicked ? 'Refreshing' : 'Refresh',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
