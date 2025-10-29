// lib/widgets/report/sleep_rhythm_summary.dart
import 'package:flutter/material.dart';

class SleepRhythmSummary extends StatelessWidget {
  const SleepRhythmSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '수면 & 신체 리듬 요약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 16),
            
            // 데이터 항목 목록
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SummaryItem(
                  title: '평균 수면 시간',
                  value: '6시간 45분 💤',
                  change: '+30분 ↑',
                  color: Color(0xFFFFE4B5), // gradient-peach 기반 색상
                ),
                SizedBox(height: 12),
                _SummaryItem(
                  title: '기상 시간 일관성',
                  value: '82% 유지 ⏰',
                  color: Color(0xFFE6D6FA), // gradient-lavender 기반 색상
                ),
                SizedBox(height: 12),
                _SummaryItem(
                  title: '생리 주기',
                  value: '안정기 진입 🌷',
                  color: Color(0xFFFDB5C1), // gradient-pink 기반 색상
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final String? change;
  final Color color;

  const _SummaryItem({required this.title, required this.value, this.change, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF374151)), // gray-700
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)), // gray-800
              ),
            ],
          ),
          if (change != null)
            Text(
              change!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF10B981)), // green-600
            ),
        ],
      ),
    );
  }
}