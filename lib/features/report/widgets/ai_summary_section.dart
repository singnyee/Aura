// lib/widgets/report/ai_summary_section.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../main.dart'; // 색상 상수 import

class AISummarySection extends StatelessWidget {
  const AISummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // HTML: gradient-pink (linear-gradient(135deg, #FDE6E9, #FDB5C1))
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDE6E9), Color(0xFFFDB5C1)],
          ),
          borderRadius: BorderRadius.circular(24), // rounded-3xl
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ], // shadow-lg
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡 이번 주 요약',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.w600, // font-semibold
                    color: Color(0xFF1F2937), // gray-800
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3), // bg-white/30
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.robot,
                      size: 20,
                      color: Color(0xFFDB2777), // pink-600
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '이번 주는 감정의 기복이 줄고, 피로도가 지난주보다 12% 감소했어요 🌿\n꾸준한 루틴 덕분에 수면 질도 좋아졌어요!',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF374151), // gray-700
                height: 1.5, // leading-relaxed
              ),
            ),
          ],
        ),
      ),
    );
  }
}