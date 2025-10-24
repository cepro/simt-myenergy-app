import 'quickchart_request.dart';

/// Service for building QuickChart.io URLs for use with Image.network()
class QuickChartService {
  static const String baseUrl = 'https://quickchart.io/chart';

  /// Builds a QuickChart.io URL from a chart request
  ///
  /// The returned URL can be used directly with Image.network() in Flutter.
  ///
  /// Parameters:
  /// - [request]: The chart configuration request
  /// - [width]: Chart width in pixels (default: 550)
  /// - [height]: Chart height in pixels (default: 350)
  /// - [backgroundColor]: Background color (default: 'white')
  /// - [format]: Output format - 'png', 'jpg', 'svg', 'webp' (default: 'png')
  ///
  /// Returns: The complete QuickChart.io URL
  ///
  /// Example:
  /// ```dart
  /// final url = QuickChartService.buildUrl(request: myRequest);
  /// Image.network(url)
  /// ```
  static String buildUrl({
    required QuickChartRequest request,
    int width = 550,
    int height = 350,
    String backgroundColor = 'white',
    String format = 'png',
  }) {
    final chartJson = request.toJsonString();
    final encodedChart = Uri.encodeComponent(chartJson);

    // Build URL manually to avoid double-encoding
    // Uri.replace() would encode the already-encoded chart parameter again
    final url = '$baseUrl?c=$encodedChart'
        '&width=$width'
        '&height=$height'
        '&backgroundColor=${Uri.encodeComponent(backgroundColor)}'
        '&format=$format';

    return url;
  }
}
