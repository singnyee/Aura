import 'package:flutter/material.dart';
import '../main.dart'; // 색상 상수 import

class TodayRecordSection extends StatelessWidget {
  const TodayRecordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘의 기록',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 16),
        
        // 기록 아이템 리스트 (가로 스크롤)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(bottom: 8), // pb-2
          child: Row(
            children: const [
              _RecordItem(emoji: '😴', title: '수면', value: '7시간'),
              SizedBox(width: 12),
              _RecordItem(emoji: '😊', title: '감정', value: '3회'),
              SizedBox(width: 12),
              _RecordItem(emoji: '🍽️', title: '식사', value: '2회'),
              SizedBox(width: 12),
              _RecordItem(emoji: '🏃', title: '운동', value: '1회'),
              SizedBox(width: 12),
              _RecordItem(emoji: '💧', title: '수분', value: '1.2L'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 기록하기 버튼
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryPink, // main.dart에서 import
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '오늘 기록하기 (60% 완료)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 🌟 하위 위젯: RecordItem
class _RecordItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String value;

  const _RecordItem({required this.emoji, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // min-w-[80px]
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Color(0xFF4B5563)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF424242)),
          ),
        ],
      ),
    );
  }
}