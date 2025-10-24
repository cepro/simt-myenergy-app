import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'quickchart_request.dart';

/// Service for building QuickChart.io URLs and fetching chart images
class QuickChartService {
  static const String baseUrl = 'https://quickchart.io/chart';

  /// Builds a QuickChart.io URL from a chart request
  ///
  /// Parameters:
  /// - [request]: The chart configuration request
  /// - [width]: Chart width in pixels (default: 550)
  /// - [height]: Chart height in pixels (default: 350)
  /// - [backgroundColor]: Background color (default: 'white')
  /// - [format]: Output format - 'png', 'jpg', 'svg', 'webp' (default: 'png')
  ///
  /// Returns: The complete QuickChart.io URL
  static String buildUrl({
    required QuickChartRequest request,
    int width = 550,
    int height = 350,
    String backgroundColor = 'white',
    String format = 'png',
  }) {
    final chartJson = request.toJsonString();
    final encodedChart = Uri.encodeComponent(chartJson);

    final queryParams = {
      'c': encodedChart,
      'width': width.toString(),
      'height': height.toString(),
      'backgroundColor': backgroundColor,
      'format': format,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    return uri.toString();
  }

  /// Fetches a chart image from QuickChart.io
  ///
  /// Parameters:
  /// - [request]: The chart configuration request
  /// - [width]: Chart width in pixels (default: 550)
  /// - [height]: Chart height in pixels (default: 350)
  /// - [backgroundColor]: Background color (default: 'white')
  /// - [format]: Output format - 'png', 'jpg', 'svg', 'webp' (default: 'png')
  ///
  /// Returns: The image data as Uint8List
  /// Throws: Exception if the request fails
  static Future<Uint8List> fetchChart({
    required QuickChartRequest request,
    int width = 550,
    int height = 350,
    String backgroundColor = 'white',
    String format = 'png',
  }) async {
    final url = buildUrl(
      request: request,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      format: format,
    );

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception(
          'Failed to fetch chart: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching chart: $e');
    }
  }

  /// Fetches a chart image and returns it as a base64 data URL
  ///
  /// Useful for embedding images directly in HTML/CSS
  ///
  /// Parameters:
  /// - [request]: The chart configuration request
  /// - [width]: Chart width in pixels (default: 550)
  /// - [height]: Chart height in pixels (default: 350)
  /// - [backgroundColor]: Background color (default: 'white')
  /// - [format]: Output format - 'png', 'jpg', 'svg', 'webp' (default: 'png')
  ///
  /// Returns: A data URL string (e.g., 'data:image/png;base64,...')
  static Future<String> fetchChartAsDataUrl({
    required QuickChartRequest request,
    int width = 550,
    int height = 350,
    String backgroundColor = 'white',
    String format = 'png',
  }) async {
    final imageBytes = await fetchChart(
      request: request,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      format: format,
    );

    final base64Image = base64Encode(imageBytes);
    final mimeType = _getMimeType(format);
    return 'data:$mimeType;base64,$base64Image';
  }

  /// Helper method to get MIME type from format
  static String _getMimeType(String format) {
    switch (format.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'svg':
        return 'image/svg+xml';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/png';
    }
  }
}
