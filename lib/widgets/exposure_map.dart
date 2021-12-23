import 'package:flutter/material.dart';
import 'package:qld_covid_map/models/exposure.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ExposureMap extends StatelessWidget {
  const ExposureMap(this.exposures, {Key? key}) : super(key: key);

  final String qldGeoSpacialDataFile = 'resources/australia.json';

  final List<Exposure> exposures;

  static const MapLatLng brisbane = MapLatLng(-27.4705, 153.0260);

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          initialLatLngBounds: const MapLatLngBounds(
            MapLatLng(-28, 151),
            MapLatLng(-26, 154),
          ),
          zoomPanBehavior: MapZoomPanBehavior(),
          initialMarkersCount: exposures.length,
          markerBuilder: (BuildContext context, int index) => MapMarker(
              latitude: exposures[index].lat!,
              longitude: exposures[index].lng!,
              child: Tooltip(
                message: exposures[index].place,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red.withOpacity(0.8),
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}

/**
 *
 *
//Shapelayer
 
late List<Model> _australiaData;
late MapShapeSource _mapShapeSource;
 
@override
void initState() {
  _australiaData = const <Model>[
    Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
        '       New\nSouth Wales'),
    Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
    Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
        'Northern\nTerritory'),
    Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
    Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
        'South Australia'),
    Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
        'Western Australia'),
    Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
    Model('Australian Capital Territory', Colors.teal, 'ACT')
  ];

  _mapShapeSource = MapShapeSource.asset(
    'assets/australia.json',
    shapeDataField: 'STATE_NAME',
    dataCount: _australiaData.length,
    primaryValueMapper: (int index) => _australiaData[index].state,
    dataLabelMapper: (int index) => _australiaData[index].stateCode,
    shapeColorValueMapper: (int index) => _australiaData[index].color,
  );
 
  super.initState();
}
 
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SfMaps(
      layers: <MapShapeLayer>[
        MapShapeLayer(
          source: _mapShapeSource,
          showDataLabels: true,
          legend: const MapLegend(MapElement.shape),
          shapeTooltipBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _australiaData[index].stateCode,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ],
    ),
  );
}
 
//Tilelayer
 
late MapZoomPanBehavior _zoomPanBehavior;
 
@override
void initState() {
  _zoomPanBehavior = MapZoomPanBehavior(minZoomLevel: 4.0);
  super.initState();
}
 
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SfMaps(
      layers: <MapTileLayer>[
        MapTileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          initialZoomLevel: 4,
          initialFocalLatLng: const MapLatLng(40.7128, -74.0060),
          zoomPanBehavior: _zoomPanBehavior,
          initialMarkersCount: 1,
          markerBuilder: (BuildContext context, int index) {
            return const MapMarker(
              latitude: 40.7128,
              longitude: -74.0060,
              child: Icon(Icons.location_on, color: Colors.red),
            );
          },
        ),
      ],
    ),
  );
}
 *
 */