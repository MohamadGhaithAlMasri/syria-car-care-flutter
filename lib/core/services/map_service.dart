import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class MapService {
  static const String _osrmBaseUrl =
      'https://router.project-osrm.org/route/v1/driving/';
  static const String _nominatimBaseUrl =
      'https://nominatim.openstreetmap.org/search';

  static final Dio _dio = Dio();

  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url =
        '$_osrmBaseUrl${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> coordinates =
            data['routes'][0]['geometry']['coordinates'];
        return coordinates
            .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
            .toList();
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
    return [];
  }

  // Search for locations
  static Future<List<dynamic>> searchLocations(String query) async {
    final url =
        '$_nominatimBaseUrl?q=${Uri.encodeComponent(query)}&format=json&limit=5&countrycodes=sy';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'User-Agent': 'syria_car_care_app'}),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('Error searching locations: $e');
    }
    return [];
  }
}
