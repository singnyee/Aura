// lib/widgets/diet_question_section.dart

import 'package:flutter/material.dart';

// 섭취 빈도 이넘 정의 (일반적인 척도로 사용 가능)
enum Frequency { never, rarely, sometimes, often }

class DietQuestionSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final dynamic groupValue;
  final ValueChanged<dynamic> onChanged;
  final Map<dynamic, String> options;

  const DietQuestionSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.groupValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 질문 제목
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF673AB7), // 주요 색상
              ),
            ),
          ),
          // 부가 설명 (PMS 연구 근거)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ),
          // 선택지 목록 (RadioListTile)
          ...options.entries.map((entry) {
            return RadioListTile(
              title: Text(
                entry.value,
                style: const TextStyle(fontSize: 15),
              ),
              value: entry.key,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: const Color(0xFF673AB7),
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
          // 섹션 구분선
          const Divider(height: 1, thickness: 1, indent: 8, endIndent: 8),
        ],
      ),
    );
  }
}