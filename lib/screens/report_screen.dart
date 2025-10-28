// lib/screens/report_screen.dart
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/report/report_header.dart';
import '../widgets/report/ai_summary_section.dart';
import '../widgets/report/sleep_rhythm_summary.dart';
import '../widgets/report/chart_placeholder.dart';
import '../main.dart'; // 색상 상수 import

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HTML body의 배경 그라데이션을 Scaffold에 적용
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          // HTML: bg-gradient-to-br from-pink-50 to-purple-50
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDF2F8), Color(0xFFFAF5FF)], // 대략적인 pink-50 to purple-50
          ),
        ),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReportHeader(), // Header
                      
                      // AI Weekly Summary
                      AISummarySection(),
                      
                      // Emotion Trend Graph
                      _ReportCard(
                        title: '감정 변화 추이 그래프',
                        subtitle: '이번 주 나의 감정 안정도 변화',
                        child: ChartPlaceholder(id: 'emotion-chart'), // 차트
                        footer: _InfoChip(
                          text: '수요일부터 에너지가 회복되는 패턴을 보였어요.', 
                          color: Color(0xFFFAF5FF), // bg-purple-50
                        ),
                      ),
                      
                      // Sleep & Rhythm Summary
                      SleepRhythmSummary(),

                      // Diet & Routine Summary
                      _DietRoutineSection(),
                      
                      // AI Insight
                      _AIInsightSection(),

                      // Emotional Feedback
                      _EmotionalFeedbackSection(),

                      // Monthly Report Section
                      _MonthlyReportSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // 기존 하단 바 사용
    );
  }
}

// ---------------------------------------------------
// 💡 재사용 가능한 기본 컨테이너 (HTML의 bg-white rounded-3xl p-6 shadow-lg)
// ---------------------------------------------------

class _ReportCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? footer;

  const _ReportCard({required this.title, this.subtitle, required this.child, this.footer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24), // rounded-3xl
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
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)), // text-lg font-semibold
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)), // text-sm text-gray-600
                ),
              ),
            child,
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

// 💡 정보 메시지 칩 (HTML의 bg-purple-50 p-3 rounded-xl)
class _InfoChip extends StatelessWidget {
  final String text;
  final Color color;
  const _InfoChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
      ),
    );
  }
}


// ---------------------------------------------------
// 🌟 기타 섹션 위젯 (복잡하지 않아 ReportScreen 내부에 정의)
// ---------------------------------------------------

class _DietRoutineSection extends StatelessWidget {
  const _DietRoutineSection();
  
  @override
  Widget build(BuildContext context) {
    return _ReportCard(
      title: '식습관 & 루틴',
      child: Column(
        children: [
          // 카페인 섭취
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Text('☕', style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('카페인 섭취: 2회', style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF1F2937))),
                    Text('지난주 대비 40% 감소', style: TextStyle(fontSize: 12, color: Color(0xFF10B981))), // text-green-600
                  ],
                ),
              ],
            ),
          ),
          
          // 루틴 실행률
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('루틴 실행률', style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                  Text('73% 🎯', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF9333EA))), // text-purple-600
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB), // bg-gray-200
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.73,
                  child: Container(
                    decoration: BoxDecoration(
                      // bg-gradient-to-r from-purple-400 to-pink-400
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA78BFA), Color(0xFFF472B6)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      footer: const _InfoChip(
        text: "'스트레칭 루틴'이 가장 효과적이었어요.",
        color: Color(0xFFFFF1F2), // bg-pink-50
      ),
    );
  }
}

class _AIInsightSection extends StatelessWidget {
  const _AIInsightSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // HTML: gradient-lavender
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF6EAFB), Color(0xFFE6D6FA)], // Adjusted lavender gradient
          ),
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
              '🤖 AI 통찰',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 16),
            const Text(
              '당신의 감정은 수면 패턴에 크게 영향을 받는 것으로 보여요.\n다음 주엔 취침 시간을 일정하게 유지해보세요.',
              style: TextStyle(fontSize: 15, color: Color(0xFF374151), height: 1.5), // text-gray-700
            ),
            const SizedBox(height: 16),
            // 버튼 (bg-white/50 text-purple-700)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF6D28D9)), // text-purple-700
                label: const Text(
                  '다음 주 추천 루틴 보기',
                  style: TextStyle(color: Color(0xFF6D28D9), fontWeight: FontWeight.w500),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmotionalFeedbackSection extends StatelessWidget {
  const _EmotionalFeedbackSection();

  @override
  Widget build(BuildContext context) {
    return _ReportCard(
      title: '', // 제목 없음
      subtitle: '', // 부제 없음
      child: Column(
        children: [
          // 🌸 아이콘 배경
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              // bg-gradient-to-br from-pink-200 to-purple-200
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFBCFE8), Color(0xFFE9D5FF)],
              ),
            ),
            alignment: Alignment.center,
            child: const Text('🌸', style: TextStyle(fontSize: 30)),
          ),
          
          // 피드백 텍스트
          const Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              '이번 주 스스로를 잘 돌보셨어요 🌸\n감정의 흐름은 완벽할 수 없지만, 꾸준히 기록하는 당신이 가장 멋져요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Color(0xFF374151), height: 1.5),
            ),
          ),
          
          // 버튼
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // bg-gradient-to-r from-pink-400 to-purple-400
              gradient: const LinearGradient(
                colors: [Color(0xFFF472B6), Color(0xFFA78BFA)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              label: const Text(
                '다음 주도 기록 시작하기',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyReportSection extends StatelessWidget {
  const _MonthlyReportSection();

  @override
  Widget build(BuildContext context) {
    return _ReportCard(
      title: '이달의 감정 곡선',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChartPlaceholder(id: 'monthly-chart'), // 월간 차트 (Placeholder)
          const SizedBox(height: 16),

          // AI가 본 당신의 변화 키워드
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5FF), // bg-purple-50
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI가 본 당신의 변화 키워드', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: const [
                    _KeywordChip(text: '균형', bgColor: Color(0xFFFBCFE8), textColor: Color(0xFF9D174D)), // bg-pink-200 text-pink-800
                    _KeywordChip(text: '회복', bgColor: Color(0xFFE9D5FF), textColor: Color(0xFF6D28D9)), // bg-purple-200 text-purple-800
                    _KeywordChip(text: '수면 개선', bgColor: Color(0xFFDBEAFE), textColor: Color(0xFF1D4ED8)), // bg-blue-200 text-blue-800
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // AI의 다음 달 예보
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // HTML: gradient-peach
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFDE6E9), Color(0xFFFFE4B5)], // Approximate peach gradient
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI의 다음 달 예보', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
                SizedBox(height: 8),
                Text(
                  '다음 배란기 전후엔 피로감이 예상돼요. 미리 휴식 계획을 세워보세요.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF374151)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KeywordChip extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const _KeywordChip({required this.text, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}