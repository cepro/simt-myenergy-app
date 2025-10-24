import 'dart:convert';

import 'quickchart_request.dart';
import 'quickchart_service.dart';

/// Example usage of QuickChart classes
///
/// This demonstrates how to:
/// 1. Build a chart request from scratch
/// 2. Load a chart request from JSON
/// 3. Update chart data dynamically
/// 4. Generate URLs and fetch images

class QuickChartExample {
  /// Creates a bar chart for monthly costs
  static QuickChartRequest createMonthlyCostChart({
    required List<String> monthLabels,
    required List<double> standingCharges,
    required List<double> powerAndLights,
    required List<double> heatingAndHotWater,
  }) {
    return QuickChartRequest(
      type: 'bar',
      data: ChartData(
        labels: monthLabels,
        datasets: [
          ChartDataset(
            label: 'Standing Charge',
            data: standingCharges,
            backgroundColor: '#95A5A6',
            stack: 'stack1',
          ),
          ChartDataset(
            label: 'Power & Lights',
            data: powerAndLights,
            backgroundColor: '#3498DB',
            stack: 'stack1',
          ),
          ChartDataset(
            label: 'Heating & Hot Water',
            data: heatingAndHotWater,
            backgroundColor: '#E74C3C',
            stack: 'stack1',
          ),
        ],
      ),
      options: ChartOptions(
        responsive: true,
        plugins: ChartPlugins(
          title: ChartTitle(
            display: true,
            text: 'Forecasted Monthly Costs',
            font: ChartFont(size: 16),
          ),
          legend: ChartLegend(display: true),
        ),
        scales: ChartScales(
          xAxes: [ChartAxis(stacked: true)],
          yAxes: [
            ChartAxis(
              stacked: true,
              scaleLabel: ChartScaleLabel(
                display: true,
                labelString: 'Cost (£)',
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
  }

  /// Example: Load from JSON (like from your quickcharts-request.json)
  static Future<void> exampleLoadFromJson(String jsonString) async {
    // Parse JSON string to Map
    final Map<String, dynamic> jsonData =
        json.decode(jsonString) as Map<String, dynamic>;

    // Create request from JSON
    final request = QuickChartRequest.fromJson(jsonData);

    // Build URL
    final url = QuickChartService.buildUrl(
      request: request,
      width: 550,
      height: 350,
      backgroundColor: 'white',
    );

    print('Chart URL: $url');
  }

  /// Example: Update existing chart with new data
  static QuickChartRequest updateChartData(
    QuickChartRequest existingRequest, {
    List<String>? newLabels,
    Map<String, List<double>>? newDatasetValues,
  }) {
    final updatedDatasets = existingRequest.data.datasets.map((dataset) {
      if (newDatasetValues != null &&
          newDatasetValues.containsKey(dataset.label)) {
        return ChartDataset(
          label: dataset.label,
          data: newDatasetValues[dataset.label]!,
          backgroundColor: dataset.backgroundColor,
          stack: dataset.stack,
        );
      }
      return dataset;
    }).toList();

    return QuickChartRequest(
      type: existingRequest.type,
      data: ChartData(
        labels: newLabels ?? existingRequest.data.labels,
        datasets: updatedDatasets,
      ),
      options: existingRequest.options,
    );
  }

  /// Example: Fetch chart image
  static Future<void> exampleFetchChart() async {
    // Create a simple chart
    final request = createMonthlyCostChart(
      monthLabels: ['Oct 24', 'Nov 24', 'Dec 24'],
      standingCharges: [12.34, 16.15, 19.58],
      powerAndLights: [45.24, 59.21, 71.78],
      heatingAndHotWater: [24.68, 32.30, 39.15],
    );

    try {
      // Fetch as bytes
      final imageBytes = await QuickChartService.fetchChart(
        request: request,
        width: 800,
        height: 400,
      );

      print('Fetched chart image: ${imageBytes.length} bytes');

      // Or fetch as data URL for embedding
      final dataUrl = await QuickChartService.fetchChartAsDataUrl(
        request: request,
        width: 800,
        height: 400,
      );

      print('Data URL: ${dataUrl.substring(0, 50)}...');
    } catch (e) {
      print('Error fetching chart: $e');
    }
  }

  /// Example: Generate URL only (no fetch)
  static String exampleGenerateUrl() {
    final request = createMonthlyCostChart(
      monthLabels: ['Jan', 'Feb', 'Mar'],
      standingCharges: [10.0, 11.0, 12.0],
      powerAndLights: [40.0, 45.0, 50.0],
      heatingAndHotWater: [20.0, 25.0, 30.0],
    );

    return QuickChartService.buildUrl(
      request: request,
      width: 600,
      height: 400,
      backgroundColor: 'transparent',
    );
  }
}
