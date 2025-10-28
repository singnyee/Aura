import 'package:flutter/material.dart';
import '../main.dart'; // 색상 상수 import

class BodyRhythmSection extends StatelessWidget {
  const BodyRhythmSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // gray-50
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 몸 리듬 요약',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF424242)),
          ),
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 텍스트 정보
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '배란기 D-2 · 피로 주의 🎉\n다음 생리 예정일까지 14일',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.5),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),

              // SVG 프로그레스 바 (Custom Paint 또는 외부 패키지 필요)
              SizedBox(
                width: 64, // w-16
                height: 64, // h-16
                child: CustomPaint(
                  painter: _CircleProgressPainter(percent: 0.50), // 50%
                  child: Center(
                    child: Text(
                      '50%',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF4B5563)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // AI 예보 참고하기 버튼
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [lightPink, primaryPink]),
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
                    'AI 예보 참고하기',
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
      ),
    );
  }
}

// 🌟 하위 위젯: CustomPainter로 원형 프로그레스 바 구현
class _CircleProgressPainter extends CustomPainter {
  final double percent;

  _CircleProgressPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. 배경 원
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade200 // text-gray-200
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // 2. 프로그레스 원
    Paint progressPaint = Paint()
      ..color = primaryPink // text-primary-pink
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 1.5; // StrokeWidth 고려

    // 배경 그리기
    canvas.drawCircle(center, radius, backgroundPaint);

    // 프로그레스 그리기 (시작 각도: -90도, 0%에서 시작)
    double sweepAngle = 2 * 3.1415926535 * percent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 2, // -90도 (시작)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}