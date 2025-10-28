import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 48, 24, 24), // pt-12, pb-6, px-6
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '유진님, 오늘의 감정 예보를\n알려드릴게요 ☀️',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242), // gray-800
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'AI가 당신의 주기와 최근 패턴을 분석했어요.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280), // gray-500
            ),
          ),
        ],
      ),
    );
  }
}