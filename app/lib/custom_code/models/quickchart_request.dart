import 'dart:convert';

/// Represents a QuickChart.io chart request
class QuickChartRequest {
  final String type;
  final ChartData data;
  final ChartOptions options;

  QuickChartRequest({
    required this.type,
    required this.data,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data.toJson(),
        'options': options.toJson(),
      };

  String toJsonString() => jsonEncode(toJson());

  factory QuickChartRequest.fromJson(Map<String, dynamic> json) {
    return QuickChartRequest(
      type: json['type'] as String,
      data: ChartData.fromJson(json['data'] as Map<String, dynamic>),
      options: ChartOptions.fromJson(json['options'] as Map<String, dynamic>),
    );
  }
}

/// Chart data containing labels and datasets
class ChartData {
  final List<String> labels;
  final List<ChartDataset> datasets;

  ChartData({
    required this.labels,
    required this.datasets,
  });

  Map<String, dynamic> toJson() => {
        'labels': labels,
        'datasets': datasets.map((d) => d.toJson()).toList(),
      };

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      labels: (json['labels'] as List).map((e) => e.toString()).toList(),
      datasets: (json['datasets'] as List)
          .map((e) => ChartDataset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Individual dataset for a chart
class ChartDataset {
  final String label;
  final List<double> data;
  final String backgroundColor;
  final String? stack;
  final String? borderColor;
  final double? borderWidth;
  final bool? fill;
  final double? tension;

  ChartDataset({
    required this.label,
    required this.data,
    required this.backgroundColor,
    this.stack,
    this.borderColor,
    this.borderWidth,
    this.fill,
    this.tension,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'label': label,
      'data': data,
      'backgroundColor': backgroundColor,
    };

    if (stack != null) json['stack'] = stack;
    if (borderColor != null) json['borderColor'] = borderColor;
    if (borderWidth != null) json['borderWidth'] = borderWidth;
    if (fill != null) json['fill'] = fill;
    if (tension != null) json['tension'] = tension;

    return json;
  }

  factory ChartDataset.fromJson(Map<String, dynamic> json) {
    return ChartDataset(
      label: json['label'] as String,
      data: (json['data'] as List).map((e) => (e as num).toDouble()).toList(),
      backgroundColor: json['backgroundColor'] as String,
      stack: json['stack'] as String?,
      borderColor: json['borderColor'] as String?,
      borderWidth: (json['borderWidth'] as num?)?.toDouble(),
      fill: json['fill'] as bool?,
      tension: (json['tension'] as num?)?.toDouble(),
    );
  }
}

/// Chart configuration options
class ChartOptions {
  final bool responsive;
  final ChartPlugins plugins;
  final ChartScales scales;

  ChartOptions({
    required this.responsive,
    required this.plugins,
    required this.scales,
  });

  Map<String, dynamic> toJson() => {
        'responsive': responsive,
        'plugins': plugins.toJson(),
        'scales': scales.toJson(),
      };

  factory ChartOptions.fromJson(Map<String, dynamic> json) {
    return ChartOptions(
      responsive: json['responsive'] as bool? ?? true,
      plugins: ChartPlugins.fromJson(json['plugins'] as Map<String, dynamic>),
      scales: ChartScales.fromJson(json['scales'] as Map<String, dynamic>),
    );
  }
}

/// Chart plugins configuration (title, legend, etc.)
class ChartPlugins {
  final ChartTitle? title;
  final ChartLegend? legend;

  ChartPlugins({
    this.title,
    this.legend,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (title != null) json['title'] = title!.toJson();
    if (legend != null) json['legend'] = legend!.toJson();
    return json;
  }

  factory ChartPlugins.fromJson(Map<String, dynamic> json) {
    return ChartPlugins(
      title: json['title'] != null
          ? ChartTitle.fromJson(json['title'] as Map<String, dynamic>)
          : null,
      legend: json['legend'] != null
          ? ChartLegend.fromJson(json['legend'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Chart title configuration
class ChartTitle {
  final bool display;
  final String text;
  final ChartFont? font;

  ChartTitle({
    required this.display,
    required this.text,
    this.font,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'display': display,
      'text': text,
    };
    if (font != null) json['font'] = font!.toJson();
    return json;
  }

  factory ChartTitle.fromJson(Map<String, dynamic> json) {
    return ChartTitle(
      display: json['display'] as bool,
      text: json['text'] as String,
      font: json['font'] != null
          ? ChartFont.fromJson(json['font'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Chart font configuration
class ChartFont {
  final int size;

  ChartFont({required this.size});

  Map<String, dynamic> toJson() => {'size': size};

  factory ChartFont.fromJson(Map<String, dynamic> json) {
    return ChartFont(size: json['size'] as int);
  }
}

/// Chart legend configuration
class ChartLegend {
  final bool display;

  ChartLegend({required this.display});

  Map<String, dynamic> toJson() => {'display': display};

  factory ChartLegend.fromJson(Map<String, dynamic> json) {
    return ChartLegend(display: json['display'] as bool);
  }
}

/// Chart scales configuration (x and y axes)
class ChartScales {
  final List<ChartAxis>? xAxes;
  final List<ChartAxis>? yAxes;

  ChartScales({
    this.xAxes,
    this.yAxes,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (xAxes != null) json['xAxes'] = xAxes!.map((a) => a.toJson()).toList();
    if (yAxes != null) json['yAxes'] = yAxes!.map((a) => a.toJson()).toList();
    return json;
  }

  factory ChartScales.fromJson(Map<String, dynamic> json) {
    return ChartScales(
      xAxes: json['xAxes'] != null
          ? (json['xAxes'] as List)
              .map((e) => ChartAxis.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      yAxes: json['yAxes'] != null
          ? (json['yAxes'] as List)
              .map((e) => ChartAxis.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

/// Individual axis configuration
class ChartAxis {
  final bool? stacked;
  final ChartScaleLabel? scaleLabel;
  final ChartTicks? ticks;

  ChartAxis({
    this.stacked,
    this.scaleLabel,
    this.ticks,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stacked != null) json['stacked'] = stacked;
    if (scaleLabel != null) json['scaleLabel'] = scaleLabel!.toJson();
    if (ticks != null) json['ticks'] = ticks!.toJson();
    return json;
  }

  factory ChartAxis.fromJson(Map<String, dynamic> json) {
    return ChartAxis(
      stacked: json['stacked'] as bool?,
      scaleLabel: json['scaleLabel'] != null
          ? ChartScaleLabel.fromJson(json['scaleLabel'] as Map<String, dynamic>)
          : null,
      ticks: json['ticks'] != null
          ? ChartTicks.fromJson(json['ticks'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Axis label configuration
class ChartScaleLabel {
  final bool display;
  final String labelString;

  ChartScaleLabel({
    required this.display,
    required this.labelString,
  });

  Map<String, dynamic> toJson() => {
        'display': display,
        'labelString': labelString,
      };

  factory ChartScaleLabel.fromJson(Map<String, dynamic> json) {
    return ChartScaleLabel(
      display: json['display'] as bool,
      labelString: json['labelString'] as String,
    );
  }
}

/// Axis ticks configuration
class ChartTicks {
  final bool? beginAtZero;
  final double? min;
  final double? max;

  ChartTicks({
    this.beginAtZero,
    this.min,
    this.max,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (beginAtZero != null) json['beginAtZero'] = beginAtZero;
    if (min != null) json['min'] = min;
    if (max != null) json['max'] = max;
    return json;
  }

  factory ChartTicks.fromJson(Map<String, dynamic> json) {
    return ChartTicks(
      beginAtZero: json['beginAtZero'] as bool?,
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );
  }
}
