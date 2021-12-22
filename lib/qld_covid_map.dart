import 'package:flutter/material.dart';
import 'package:qld_covid_map/exposure_loader.dart';
import 'package:qld_covid_map/main.dart';
import 'package:qld_covid_map/models/exposure.dart';
import 'package:qld_covid_map/widgets/exposure_list.dart';
import 'package:url_launcher/url_launcher.dart';

class QLDCovidMap extends StatefulWidget {
  const QLDCovidMap({Key? key}) : super(key: key);

  @override
  State<QLDCovidMap> createState() => _QLDCovidMapState();
}

class _QLDCovidMapState extends State<QLDCovidMap> {
  Row get topInfoString => Row(
        children: [
          const Text("All details have been loaded from: "),
          TextButton(
              onPressed: () => launch(ExposureLoader.url, enableJavaScript: true),
              child: const Text(
                  "https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/contact-tracing",
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)))
        ],
      );

  Future<List<Exposure>> exposuresLoad = ExposureLoader.load();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QLD Covid Map")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            topInfoString,
            const SizedBox(height: 20),
            FutureBuilder(
              future: exposuresLoad,
              builder: (BuildContext context, AsyncSnapshot<List<Exposure>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData && (snapshot.data != null)) {
                    return Expanded(child: ExposureList(ExposureDataSource(exposures: snapshot.data ?? [])));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            )
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
            padding: const EdgeInsets.all(8.0),
            height: 50,
            color: Colors.blue,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: ["Version $BUILD_VERSION", "Made by Harry Guthrie"]
                    .map<Widget>((e) => Text(e, style: const TextStyle(color: Colors.white)))
                    .toList()
                    .fold<List<Widget>>([], (p, e) => [...p, const SizedBox(width: 30), e]))),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async => setState(() => exposuresLoad = ExposureLoader.load()),
      //   tooltip: "Reload",
      //   child: const Icon(Icons.refresh),
      // ));
    );
  }
}
