import 'dart:convert';

import 'package:qld_covid_map/models/exposure.dart';
import 'package:http/http.dart' as http;

class ExposureLoader {
  static String get url => "https://australia-southeast1-qld-covid-map.cloudfunctions.net/scraper";

  static Future<List<Exposure>> load() async {
    http.Response response = await http.get(Uri.parse(url));

    return List.from(jsonDecode(utf8.decode(response.bodyBytes))["exposures"])
        .map<Exposure>((e) => Exposure.fromJSON(Map<String, dynamic>.from(e)))
        .toList();
  }
}
