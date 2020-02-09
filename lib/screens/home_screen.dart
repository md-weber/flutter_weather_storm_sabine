import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../secret.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: WeatherApi().fetchData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("WindSpeed is today: "),
                      Text(
                        snapshot.data.toString(),
                        style: TextStyle(fontSize: 102.0),
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class WeatherApi {
  String cityName = "Karlsruhe";

  fetchData() async {
    String apiURL =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

    var data = await http.get(apiURL);
    var info = jsonDecode(data.body)["wind"]["speed"];
    return info;
  }
}
