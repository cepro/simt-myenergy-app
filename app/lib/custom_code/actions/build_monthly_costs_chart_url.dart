// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/models/quickchart_request.dart';
import '/custom_code/models/quickchart_service.dart';

/// Builds a QuickChart URL from monthly costs data
///
/// Creates a stacked bar chart showing both actual and forecast data:
/// - Standing (Actual) - gray solid
/// - Standing (Forecast) - gray transparent
/// - Power (Actual) - blue solid
/// - Power (Forecast) - blue transparent
/// - Heat (Actual) - red solid
/// - Heat (Forecast) - red transparent
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

  // Sort costs by month (latest first) to get the most recent data
  final sortedCosts = List<MonthlyCostStruct>.from(monthlyCosts);
  sortedCosts.sort((a, b) {
    if (a.monthTyped != null && b.monthTyped != null) {
      return b.monthTyped!.compareTo(a.monthTyped!);
    }
    return b.month.compareTo(a.month);
  });

  // Take only the most recent 24 months
  final recentCosts = sortedCosts.take(24).toList();
  
  // Reverse back to earliest first for chart display
  recentCosts.sort((a, b) {
    if (a.monthTyped != null && b.monthTyped != null) {
      return a.monthTyped!.compareTo(b.monthTyped!);
    }
    return a.month.compareTo(b.month);
  });

  // Extract labels and separate actual vs forecast data
  var labels = <String>[];
  var standingActual = <double>[];
  var standingForecast = <double>[];
  var powerActual = <double>[];
  var powerForecast = <double>[];
  var heatActual = <double>[];
  var heatForecast = <double>[];

  final now = DateTime.now();

  for (final cost in recentCosts) {
    labels.add(cost.month);
    
    // Determine if this is actual (past) or forecast (future) data
    bool isForecast = false;
    if (cost.monthTyped != null) {
      // If month is in the future, it's forecast data
      isForecast = cost.monthTyped!.isAfter(now);
    } else {
      // Fallback: check if month string contains future year
      final currentYear = now.year;
      final costYear = int.tryParse(cost.month.split('-').first);
      if (costYear != null && costYear > currentYear) {
        isForecast = true;
      }
    }

    if (isForecast) {
      // Future data - forecast
      standingActual.add(0.0);
      standingForecast.add(cost.standingCharge);
      powerActual.add(0.0);
      powerForecast.add(cost.power);
      heatActual.add(0.0);
      heatForecast.add(cost.heat);
    } else {
      // Past data - actual
      standingActual.add(cost.standingCharge);
      standingForecast.add(0.0);
      powerActual.add(cost.microgridPower);
      powerForecast.add(0.0);
      heatActual.add(cost.microgridHeat);
      heatForecast.add(0.0);
    }
  }

  // Create the chart request with new structure
  final request = QuickChartRequest(
    type: 'bar',
    data: ChartData(
      labels: labels,
      datasets: [
        ChartDataset(
          label: 'Standing (Actual)',
          data: standingActual,
          backgroundColor: '#95A5A6',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Standing (Forecast)',
          data: standingForecast,
          backgroundColor: 'rgba(149, 165, 166, 0.5)',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Power (Actual)',
          data: powerActual,
          backgroundColor: '#3498DB',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Power (Forecast)',
          data: powerForecast,
          backgroundColor: 'rgba(52, 152, 219, 0.5)',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Heat (Actual)',
          data: heatActual,
          backgroundColor: '#E74C3C',
          stack: 'stack1',
        ),
        ChartDataset(
          label: 'Heat (Forecast)',
          data: heatForecast,
          backgroundColor: 'rgba(231, 76, 60, 0.5)',
          stack: 'stack1',
        ),
      ],
    ),
    options: ChartOptions(
      responsive: true,
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
      plugins: ChartPlugins(
        legend: ChartLegend(
          display: true,
        ),
        title: ChartTitle(
          display: true,
          text: 'Monthly Cost Breakdown',
          font: ChartFont(size: 16),
        ),
      ),
    ),
  );

  // Build and return the URL
  return QuickChartService.buildUrl(
    request: request,
    width: width,
    height: 400,
    backgroundColor: 'white',
    format: 'svg',
  );
}
