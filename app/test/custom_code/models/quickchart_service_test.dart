import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_energy/custom_code/models/quickchart_request.dart';
import 'package:my_energy/custom_code/models/quickchart_service.dart';

void main() {
  group('QuickChartService', () {
    group('buildUrl', () {
      test('builds correct URL with default parameters', () {
        // Arrange
        final request = QuickChartRequest(
          type: 'bar',
          data: ChartData(
            labels: ['Jan', 'Feb', 'Mar'],
            datasets: [
              ChartDataset(
                label: 'Sales',
                data: [10.0, 20.0, 30.0],
                backgroundColor: '#FF0000',
              ),
            ],
          ),
          options: ChartOptions(
            responsive: true,
            plugins: ChartPlugins(
              title: ChartTitle(
                display: true,
                text: 'Test Chart',
              ),
              legend: ChartLegend(display: true),
            ),
            scales: ChartScales(
              xAxes: [ChartAxis(stacked: false)],
              yAxes: [ChartAxis(stacked: false)],
            ),
          ),
        );

        // Act
        final url = QuickChartService.buildUrl(request: request);

        // Assert
        expect(url, startsWith('https://quickchart.io/chart?'));
        expect(url, contains('width=550'));
        expect(url, contains('height=350'));
        expect(url, contains('backgroundColor=white'));
        expect(url, contains('format=png'));
        expect(url, contains('c=')); // Contains encoded chart data
      });

      test('builds URL with custom dimensions', () {
        // Arrange
        final request = QuickChartRequest(
          type: 'line',
          data: ChartData(
            labels: ['A'],
            datasets: [
              ChartDataset(
                label: 'Test',
                data: [1.0],
                backgroundColor: '#000000',
              ),
            ],
          ),
          options: ChartOptions(
            responsive: true,
            plugins: ChartPlugins(),
            scales: ChartScales(),
          ),
        );

        // Act
        final url = QuickChartService.buildUrl(
          request: request,
          width: 800,
          height: 600,
        );

        // Assert
        expect(url, contains('width=800'));
        expect(url, contains('height=600'));
      });

      test('builds URL with custom background color', () {
        // Arrange
        final request = QuickChartRequest(
          type: 'pie',
          data: ChartData(
            labels: ['Red', 'Blue'],
            datasets: [
              ChartDataset(
                label: 'Colors',
                data: [50.0, 50.0],
                backgroundColor: '#FFFFFF',
              ),
            ],
          ),
          options: ChartOptions(
            responsive: true,
            plugins: ChartPlugins(),
            scales: ChartScales(),
          ),
        );

        // Act
        final url = QuickChartService.buildUrl(
          request: request,
          backgroundColor: 'transparent',
        );

        // Assert
        expect(url, contains('backgroundColor=transparent'));
      });

      test('builds URL with custom format', () {
        // Arrange
        final request = QuickChartRequest(
          type: 'bar',
          data: ChartData(
            labels: ['Q1'],
            datasets: [
              ChartDataset(
                label: 'Revenue',
                data: [100.0],
                backgroundColor: '#00FF00',
              ),
            ],
          ),
          options: ChartOptions(
            responsive: true,
            plugins: ChartPlugins(),
            scales: ChartScales(),
          ),
        );

        // Act
        final url = QuickChartService.buildUrl(
          request: request,
          format: 'svg',
        );

        // Assert
        expect(url, contains('format=svg'));
      });

      test('properly encodes chart JSON in URL', () {
        // Arrange
        final request = QuickChartRequest(
          type: 'bar',
          data: ChartData(
            labels: ['Test Label'],
            datasets: [
              ChartDataset(
                label: 'Test Dataset',
                data: [42.5],
                backgroundColor: '#3498DB',
              ),
            ],
          ),
          options: ChartOptions(
            responsive: true,
            plugins: ChartPlugins(
              title: ChartTitle(
                display: true,
                text: 'Test Chart Title',
              ),
            ),
            scales: ChartScales(),
          ),
        );

        // Act
        final url = QuickChartService.buildUrl(request: request);

        // Assert
        // Should be a valid URL
        final uri = Uri.parse(url);
        expect(uri.isAbsolute, isTrue);
        expect(uri.scheme, equals('https'));
        expect(uri.host, equals('quickchart.io'));

        // The chart parameter should be present and contain encoded data
        expect(uri.queryParameters['c'], isNotNull);

        // Decode the parameter to verify the content
        final chartJson = Uri.decodeComponent(uri.queryParameters['c']!);
        final chartData = jsonDecode(chartJson);

        expect(chartData['type'], equals('bar'));
        expect(chartData['data']['datasets'][0]['label'], equals('Test Dataset'));
        expect(chartData['options']['plugins']['title']['text'], equals('Test Chart Title'));
      });

      test('handles stacked bar chart configuration', () {
        // Arrange - Similar to your monthly costs example
        final request = QuickChartRequest(
          type: 'bar',
          data: ChartData(
            labels: ['Oct 24', 'Nov 24', 'Dec 24'],
            datasets: [
              ChartDataset(
                label: 'Standing Charge',
                data: [12.34, 16.15, 19.58],
                backgroundColor: '#95A5A6',
                stack: 'stack1',
              ),
              ChartDataset(
                label: 'Power & Lights',
                data: [45.24, 59.21, 71.78],
                backgroundColor: '#3498DB',
                stack: 'stack1',
              ),
              ChartDataset(
                label: 'Heating & Hot Water',
                data: [24.68, 32.30, 39.15],
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

        // Act
        final url = QuickChartService.buildUrl(
          request: request,
          width: 550,
          height: 350,
        );

        // Assert
        expect(url, startsWith('https://quickchart.io/chart?'));
        expect(url, contains('width=550'));
        expect(url, contains('height=350'));

        // Verify it's a valid URI
        final uri = Uri.parse(url);
        expect(uri.isAbsolute, isTrue);

        // Verify the chart data is present in the URL by decoding the parameter
        final chartParam = uri.queryParameters['c'];
        expect(chartParam, isNotNull);

        // Decode and parse the JSON to verify content
        final chartJson = Uri.decodeComponent(chartParam!);
        final chartData = jsonDecode(chartJson);

        // Verify chart structure
        expect(chartData['type'], equals('bar'));
        expect(chartData['options']['plugins']['title']['text'], equals('Forecasted Monthly Costs'));

        // Verify datasets
        final datasets = chartData['data']['datasets'] as List;
        expect(datasets.length, equals(3));
        expect(datasets[0]['label'], equals('Standing Charge'));
        expect(datasets[0]['stack'], equals('stack1'));
        expect(datasets[1]['label'], equals('Power & Lights'));
        expect(datasets[2]['label'], equals('Heating & Hot Water'));

        // Verify labels
        final labels = chartData['data']['labels'] as List;
        expect(labels, contains('Oct 24'));
        expect(labels, contains('Nov 24'));
        expect(labels, contains('Dec 24'));
      });
    });
  });
}
