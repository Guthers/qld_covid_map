import 'package:intl/intl.dart';

class Exposure {
  // "data-added": "2021-12-21T16:01"
  static final dateAddedFormat = DateFormat('yyyy-MM-ddThh:mm');
  final DateTime dateAdded;

  // Will initally be url encoded
  // "data-address": "627%20Rode%20Rd",
  final String address;

  // "data-advice": "Casual",
  final ExposureType type;

  // "data-date": "2021-12-20T22:00",
  // "data-datetext": "Monday%2020%20December%202021",
  final DateTime date;

  // "data-timetext": "10pm%20-%202am"
  final String time;

  // "data-suburb": "Chermside",
  final String suburb;

  // "data-location": "Prince%20Charles%20Hospital%20Emergency%20Department",
  final String place;

  // "data-lgas": "QLD21",
  final String lga;

  Exposure.fromJSON(Map<String, dynamic> json)
      : dateAdded = dateAddedFormat.parseStrict(json["data-added"]!),
        address = Uri.decodeFull(json["data-address"]!),
        type = json["data-advice"]! == "Casual"
            ? ExposureType.Casual
            : (json["data-advice"]! == "Close" ? ExposureType.Close : ExposureType.SelfIsolate),
        date = dateAddedFormat.parseStrict(json["data-date"]!),
        time = Uri.decodeFull(json["data-timetext"]!),
        suburb = Uri.decodeFull(json["data-suburb"]!),
        place = Uri.decodeFull(json["data-location"]!),
        lga = Uri.decodeFull(json["data-lgas"]!);
}

enum ExposureType { Casual, Close, SelfIsolate }
