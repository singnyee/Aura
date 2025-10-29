import 'package:flutter/material.dart';
import '../main.dart'; // 색상 상수 import

class AIRoutineSection extends StatelessWidget {
  const AIRoutineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 제목 및 설명
        const Text(
          '오늘의 맞춤 루틴',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 2),
        const Text(
          'AI가 오늘의 감정 예보에 맞는 루틴을 추천드려요.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 16),
        
        // 루틴 목록
        const Column(
          children: [
            _RoutineItem(emoji: '☕', title: '따뜻한 차 마시기', status: 'start'),
            SizedBox(height: 12),
            _RoutineItem(emoji: '🧘', title: '10분 스트레칭', status: 'done'),
            SizedBox(height: 12),
            _RoutineItem(emoji: '📵', title: '디지털 디톡스', status: 'start'),
          ],
        ),
      ],
    );
  }
}

// 🌟 하위 위젯: RoutineItem
class _RoutineItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String status;

  const _RoutineItem({required this.emoji, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    bool isDone = status == 'done';
    
    Color buttonTextColor = isDone ? const Color(0xFF4B5563) : Colors.white;
    Gradient? buttonGradient = isDone 
        ? null
        : const LinearGradient(colors: [lightPink, primaryPink]);
    Color buttonColor = isDone ? const Color(0xFFF3F4F6) : Colors.transparent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF424242),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: buttonGradient,
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    isDone ? '완료됨' : '시작하기',
                    style: TextStyle(
                      color: buttonTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}