import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/aura_colors.dart';

// 🌟 1. [추가] 새로 만든 수면 기록 화면을 import 합니다.
import '../record/sleep_record_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 🌟 2. [수정] 메서드 호출 시 context를 넘겨줍니다. (Navigator가 context를 사용하기 때문)
      body: buildMainContent(context), 
      bottomNavigationBar: buildBottomNavBar(), 
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  // 🌟 3. [수정] context를 받도록 시그니처 변경
  Widget buildMainContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero, 
      children: [
        // 🌟 수정: 메서드 이름에서 _ 제거
        buildHeader(), // <header id="header">

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🌟 수정: 메서드 이름에서 _ 제거
              buildEmotionForecast(), // <section id="emotion-forecast">
              const SizedBox(height: 24), // space-y-6
              buildAiRoutine(), // <section id="ai-routine">
              const SizedBox(height: 24), // space-y-6
              // 🌟 4. [수정] context를 하위 메서드로 전달
              buildTodayRecord(context), // <section id="today-record">
              const SizedBox(height: 24), // space-y-6
              buildBodyRhythm(), // <section id="body-rhythm">
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '유진님, 오늘의 감정 예보를\n알려드릴게요 ☀️',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.w500, 
              color: AuraColors.gray800,
              height: 1.5, 
            ),
          ),
          const SizedBox(height: 8), // mt-2
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

  // 🌟 수정: 메서드 이름에서 _ 제거
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
              // 🌟 수정: 메서드 이름에서 _ 제거
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

  // 🌟 수정: 메서드 이름에서 _ 제거
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

  // 🌟 수정: 메서드 이름에서 _ 제거
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
        // 🌟 수정: 메서드 이름에서 _ 제거
        buildRoutineItem('☕', '따뜻한 차 마시기', isCompleted: false),
        const SizedBox(height: 12), 
        buildRoutineItem('🧘', '10분 스트레칭', isCompleted: true),
        const SizedBox(height: 12), 
        buildRoutineItem('📵', '디지털 디톡스', isCompleted: false),
      ],
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildRoutineItem(String icon, String title,
      {bool isCompleted = false}) {
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
          // 🌟 수정: 메서드 이름에서 _ 제거
          isCompleted
              ? buildGrayButton() // 완료됨 버튼
              : buildPinkButton(), // 시작하기 버튼
        ],
      ),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
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

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildGrayButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AuraColors.gray100, 
        foregroundColor: AuraColors.gray600, 
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        '완료됨',
        style: TextStyle(fontSize: 14), 
      ),
    );
  }

  // 🌟 5. [수정] context를 받도록 시그니처 변경
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
              // 🌟 수정: 메서드 이름에서 _ 제거
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
          // 🌟 6. [핵심] onPressed에 화면 이동(Navigation) 로직을 추가합니다.
          onPressed: () {
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
            '오늘 기록하기 (60% 완료)',
            style: TextStyle(
              fontWeight: FontWeight.w500, 
            ),
          ),
        ),
      ],
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
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

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildBodyRhythm() {
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12), 
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

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 4, 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🌟 수정: 메서드 이름에서 _ 제거
            buildNavItem(FontAwesomeIcons.house, '홈', isActive: true),
            buildNavItem(FontAwesomeIcons.calendar, '기록'),
            buildNavItem(FontAwesomeIcons.robot, 'AI 루틴'),
            buildNavItem(FontAwesomeIcons.chartLine, 'AI 리포트'),
            buildNavItem(FontAwesomeIcons.user, '마이'),
          ],
        ),
      ),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildNavItem(IconData icon, String label, {bool isActive = false}) {
    final Color color = isActive ? AuraColors.primaryPink : AuraColors.gray400;

    return Column(
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
    );
  }
}