// lib/widgets/report/chart_placeholder.dart
import 'package:flutter/material.dart';

class ChartPlaceholder extends StatelessWidget {
  final String id; // 차트 ID (emotion-chart, monthly-chart)

  const ChartPlaceholder({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      // HTML: h-48 (높이 192px)
      height: 192, 
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // 차트 영역을 구분하기 위한 배경색
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        '[$id] 차트 영역\n(fl_chart 등의 패키지로 구현 필요)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      ),
    );
  }
}