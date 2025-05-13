import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  const PieChartWidget({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sections = dataMap.entries.map((entry) {
      final color = Colors.primaries[dataMap.keys.toList().indexOf(entry.key) % Colors.primaries.length];
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.key}\n₹${entry.value.toStringAsFixed(0)}',
        radius: 80,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return dataMap.isEmpty
        ? const Center(child: Text('No data available'))
        : PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
            ),
          );
  }
}
