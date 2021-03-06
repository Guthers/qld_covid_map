import 'package:flutter/material.dart';
import 'package:qld_covid_map/qld_covid_map.dart';

// ignore: constant_identifier_names
const String BUILD_VERSION = "0.0.2";

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'QLD Covid Map',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const QLDCovidMap(),
        debugShowCheckedModeBanner: false,
      );
}
