import 'package:flutter/material.dart';
import 'package:qld_covid_map/qld_covid_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QLD Covid Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QLDCovidMap(),
      debugShowCheckedModeBanner: false,
    );
  }
}
