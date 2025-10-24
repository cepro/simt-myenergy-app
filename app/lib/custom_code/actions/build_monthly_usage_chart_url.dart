// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/models/quickchart_request.dart';
import '/custom_code/models/quickchart_service.dart';

/// Builds a QuickChart URL from monthly usage data
///
/// Creates a line chart showing:
/// - Power & Lights (blue line)
/// - Heating & Hot Water (red line)
///
/// Returns the URL that can be used with Image.network()
Future<String> buildMonthlyUsageChartUrl(
  List<MonthlyUsageStruct> monthlyUsage,
) async {
  // Return empty string if no data
  if (monthlyUsage.isEmpty) {
    return '';
  }

  // Extract labels (month names) and data arrays
  final labels = <String>[];
  final powerData = <double>[];
  final heatData = <double>[];

  for (final usage in monthlyUsage) {
    labels.add(usage.month);
    powerData.add(usage.usagePower);
    heatData.add(usage.usageHeat);
  }

  // Create the chart request
  final request = QuickChartRequest(
    type: 'line',
    data: ChartData(
      labels: labels,
      datasets: [
        ChartDataset(
          label: 'Power & Lights',
          data: powerData,
          borderColor: '#3498DB',
          backgroundColor: 'rgba(52, 152, 219, 0.1)',
          borderWidth: 3,
          fill: true,
          tension: 0.3,
        ),
        ChartDataset(
          label: 'Heating & Hot Water',
          data: heatData,
          borderColor: '#E74C3C',
          backgroundColor: 'rgba(231, 76, 60, 0.1)',
          borderWidth: 3,
          fill: true,
          tension: 0.3,
        ),
      ],
    ),
    options: ChartOptions(
      responsive: true,
      plugins: ChartPlugins(
        title: ChartTitle(
          display: true,
          text: 'Energy Consumption Forecast',
          font: ChartFont(size: 16),
        ),
        legend: ChartLegend(display: true),
      ),
      scales: ChartScales(
        yAxes: [
          ChartAxis(
            scaleLabel: ChartScaleLabel(
              display: true,
              labelString: 'kWh',
            ),
            ticks: ChartTicks(
              beginAtZero: true,
              min: 0,
            ),
          ),
        ],
      ),
    ),
  );

  // Build and return the URL
  return QuickChartService.buildUrl(
    request: request,
    width: 550,
    height: 350,
    backgroundColor: 'white',
  );
}
