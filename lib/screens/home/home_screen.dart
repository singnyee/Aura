import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/aura_colors.dart';
import '../record/sleep_record_screen.dart';
import '../report/ai_report_screen.dart';
// 🌟 1. [추가] 달력 화면 import
import '../calendar/calendar_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; 

  final List<Widget> screens = [
    const HomeContent(), // 0: 홈
    // 🌟 2. [수정] 기록 탭은 Placeholder (탭 클릭 시 CalendarScreen을 push할 것이므로)
    Container(), // This container is technically not shown due to the push logic
    const Center(child: Text('AI 루틴 화면 (구현 예정)')), // 2: AI 루틴
    const AiReportScreen(), // 3: AI 리포트
    const Center(child: Text('마이 화면 (구현 예정)')), // 4: 마이
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedIndex], 
      bottomNavigationBar: buildBottomNavBar(selectedIndex, (index) {
        // 🌟 3. [수정] '기록' 탭 (index 1) 로직 변경
        if (index == 1) {
          // Push CalendarScreen instead of changing the index
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalendarScreen()),
          );
          // Don't change selectedIndex when pushing a new route for the calendar
        } else {
          // Switch tabs for other indices
          setState(() {
            selectedIndex = index; 
          });
        }
      }),
    );
  }

  Widget buildBottomNavBar(int currentIndex, Function(int) onTap) {
     return BottomAppBar(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavItem(FontAwesomeIcons.house, '홈', currentIndex == 0, () => onTap(0)),
            buildNavItem(FontAwesomeIcons.calendar, '기록', false, () => onTap(1)), // 기록 탭은 항상 비활성 상태로 표시 (push 로직 때문)
            buildNavItem(FontAwesomeIcons.robot, 'AI 루틴', currentIndex == 2, () => onTap(2)),
            buildNavItem(FontAwesomeIcons.chartLine, 'AI 리포트', currentIndex == 3, () => onTap(3)),
            buildNavItem(FontAwesomeIcons.user, '마이', currentIndex == 4, () => onTap(4)),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    final Color color = isActive ? AuraColors.primaryPink : AuraColors.gray400;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildEmotionForecast(),
              const SizedBox(height: 24),
              buildAiRoutine(),
              const SizedBox(height: 24),
              buildTodayRecord(context), 
              const SizedBox(height: 24),
              // 🌟 4. [수정] buildBodyRhythm에 context 전달
              buildBodyRhythm(context), 
            ],
          ),
        ),
        // Adjusted SizedBox for bottom padding to prevent overlap with BottomNavBar
        const SizedBox(height: 80), 
      ],
    );
  }

  // --- build methods moved from original HomeScreen ---
  Widget buildHeader() { 
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '송이님, 오늘의 감정 예보를\n알려드릴게요 ☀️',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AuraColors.gray800,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI가 당신의 주기와 최근 패턴을 분석했어요.',
            style: TextStyle(
              fontSize: 14,
              color: AuraColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildEmotionForecast() { 
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AuraColors.lavender,
            AuraColors.pinkEnd,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '오늘의 감정 예보',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AuraColors.gray800,
            ),
          ),
          const Text(
            'AI 기반 개인 맞춤 예측',
            style: TextStyle(
              fontSize: 14,
              color: AuraColors.gray600,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              buildForecastCard('☀️', '기분', '좋음'),
              const SizedBox(width: 12),
              buildForecastCard('☁️', 'PMS 위험', '낮음'),
              const SizedBox(width: 12),
              buildForecastCard('⚡', '에너지', '높음'),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'AI 예보에 따라 오늘은 집중력이 높아요. 중요한 일을 처리하기 좋은 날이에요 🌷',
              style: TextStyle(
                fontSize: 14,
                color: AuraColors.gray700,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildForecastCard(String icon, String title, String value) { 
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AuraColors.gray700,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AuraColors.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildAiRoutine() { 
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘의 맞춤 루틴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AuraColors.gray800,
          ),
        ),
        const Text(
          'AI가 오늘의 감정 예보에 맞는 루틴을 추천드려요.',
          style: TextStyle(
            fontSize: 14,
            color: AuraColors.gray600,
          ),
        ),
        const SizedBox(height: 16),

        buildRoutineItem('☕', '따뜻한 차 마시기', isCompleted: false),
        const SizedBox(height: 12),
        buildRoutineItem('🧘', '10분 스트레칭', isCompleted: true),
        const SizedBox(height: 12),
        buildRoutineItem('📵', '디지털 디톡스', isCompleted: false),
      ],
    );
  }
  Widget buildRoutineItem(String icon, String title, {bool isCompleted = false}) { 
     return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AuraColors.gray100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: AuraColors.gray800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          isCompleted ? buildGrayButton() : buildPinkButton(),
        ],
      ),
    );
  }
  Widget buildPinkButton() { 
     return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AuraColors.lightPink, AuraColors.primaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          '시작하기',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget buildGrayButton() { 
    // 🌟 [수정] 핑크 버튼과 동일한 구조로 변경
    return Container(
      decoration: BoxDecoration(
        color: AuraColors.gray100, // 🌟 배경색을 Container가 담당
        borderRadius: BorderRadius.circular(8), // 🌟 모양도 Container가 담당
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // 🌟 버튼 자체는 투명하게
          shadowColor: Colors.transparent, // 🌟 버튼 자체는 투명하게
          foregroundColor: AuraColors.gray600, // 텍스트 색상은 유지
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8), 
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 핑크 버튼과 동일한 설정
        ),
        child: const Text(
          '완료됨',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
  Widget buildTodayRecord(BuildContext context) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘의 기록',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildRecordChip('😴', '수면', '7시간'),
              const SizedBox(width: 12),
              buildRecordChip('😊', '감정', '3회'),
              const SizedBox(width: 12),
              buildRecordChip('🍽️', '식사', '2회'),
              const SizedBox(width: 12),
              buildRecordChip('🏃', '운동', '1회'),
              const SizedBox(width: 12),
              buildRecordChip('💧', '수분', '1.2L'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            // Start recording flow
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SleepRecordScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AuraColors.primaryPink,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            '오늘 기록하기',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildRecordChip(String icon, String title, String value) { 
    return Container(
      width: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AuraColors.gray100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AuraColors.gray600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AuraColors.gray800,
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 5. [수정] buildBodyRhythm now requires context
  Widget buildBodyRhythm(BuildContext context) {
     return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.gray50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 몸 리듬 요약',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AuraColors.gray800,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  '배란기 D-2 · 피로 주의 🎉\n다음 생리 예정일까지 14일',
                  style: TextStyle(
                    fontSize: 14,
                    color: AuraColors.gray700,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: AuraColors.gray200,
                      color: AuraColors.primaryPink,
                      strokeWidth: 5,
                    ),
                    const Text(
                      '50%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AuraColors.gray700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 🌟 6. [수정] 'AI 예보 참고하기' button onPressed logic added
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AuraColors.lightPink, AuraColors.primaryPink],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to AI Report Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AiReportScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'AI 예보 참고하기',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} // End of HomeContent