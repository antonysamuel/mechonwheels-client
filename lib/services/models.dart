import 'package:url_launcher/url_launcher.dart';

class Workshops {
  String name;
  String address;
  int phone;
  double lat;
  double lon;
  Workshops(this.name, this.address, this.phone, this.lat, this.lon);
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
