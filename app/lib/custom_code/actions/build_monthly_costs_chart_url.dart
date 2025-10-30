// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/models/quickchart_request.dart';
import '/custom_code/models/quickchart_service.dart';

/// Builds a QuickChart URL from monthly costs data
///
/// Creates a stacked bar chart showing:
/// - Standing Charge (gray)
/// - Power & Lights (blue)
/// - Heating & Hot Water (red)
///
/// Returns the URL that can be used with Image.network()
Future<String> buildMonthlyCostsChartUrl(
  List<MonthlyCostStruct> monthlyCosts, {
  int width = 550,
}) async {
  // Return empty string if no data
  if (monthlyCosts.isEmpty) {
    return '';
  }

  // Extract labels (month names) and data arrays
  var labels = <String>[];
  var standingCharges = <double>[];
  var powerData = <double>[];
  var heatData = <double>[];

  for (final cost in monthlyCosts) {
    labels.add(cost.month);
    standingCharges.add(cost.standingCharge);
    powerData.add(cost.power);
    heatData.add(cost.heat);
  }

  // Reverse the order to display ascending by month
  labels = labels.reversed.toList();
  standingCharges = standingCharges.reversed.toList();
  powerData = powerData.reversed.toList();
  heatData = heatData.reversed.toList();

  // Create the chart request
  final request = QuickChartRequest(
    type: 'bar',
    data: ChartData(
      labels: labels,
      datasets: [
        ChartDataset(
          label: 'Standing Charge',
          data: standingCharges,
          backgroundColor: '#95A5A6',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Power & Lights',
          data: powerData,
          backgroundColor: '#3498DB',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Heating & Hot Water',
          data: heatData,
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

  // Build and return the URL
  return QuickChartService.buildUrl(
    request: request,
    width: width,
    height: 350,
    backgroundColor: 'white',
    format: 'svg',
  );
}
