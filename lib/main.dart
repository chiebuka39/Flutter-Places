import 'package:flutter/material.dart';
import 'package:places_finder/api/places_prediction_api.dart';
import 'package:places_finder/repository/places_prediction_repository.dart';
import 'package:places_finder/ui/home_page.dart';

void main() {


 return runApp(MyApp());
}
class MyApp extends StatelessWidget {


  const MyApp({
    Key key,
  }): super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cofee finder',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyMapPage(title: 'Cofee finder'),
    );
  }
}

