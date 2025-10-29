import 'package:flutter/material.dart';
import '../main.dart'; // 색상 상수 import

class EmotionForecastSection extends StatelessWidget {
  const EmotionForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [lavender, pinkEnd], // main.dart에서 import
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          const Text(
            '오늘의 감정 예보',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF424242)),
          ),
          const SizedBox(height: 2),
          const Text(
            'AI 기반 개인 맞춤 예측',
            style: TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
          ),
          const SizedBox(height: 16),

          // 그리드 (감정, PMS, 에너지)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ForecastItem(emoji: '☀️', title: '기분', value: '좋음'),
              _ForecastItem(emoji: '☁️', title: 'PMS 위험', value: '낮음'),
              _ForecastItem(emoji: '⚡', title: '에너지', value: '높음'),
            ],
          ),
          const SizedBox(height: 16),

          // AI 예보 메시지
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'AI 예보에 따라 오늘은 집중력이 높아요. 중요한 일을 처리하기 좋은 날이에요 🌷',
              style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
            ),
          ),
        ],
      ),
    );
  }
}

// 🌟 하위 위젯: ForecastItem
class _ForecastItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String value;

  const _ForecastItem({required this.emoji, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24, height: 1.0)),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF4B5563)),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 10, color: Color(0xFF4B5563)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}