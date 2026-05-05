import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapService {
  static const String _osrmBaseUrl = 'https://router.project-osrm.org/route/v1/driving/';
  static const String _nominatimBaseUrl = 'https://nominatim.openstreetmap.org/search';

  // Get route between two points
  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url = '$_osrmBaseUrl${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
        return coordinates.map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble())).toList();
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
    return [];
  }

  // Search for locations
  static Future<List<dynamic>> searchLocations(String query) async {
    final url = '$_nominatimBaseUrl?q=${Uri.encodeComponent(query)}&format=json&limit=5&countrycodes=sy';
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'syria_car_care_app'},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Error searching locations: $e');
    }
    return [];
  }
}
