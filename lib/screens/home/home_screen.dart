// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/aura_colors.dart'; // 방금 만든 색상 파일 import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HTML의 <body class="bg-white">와 <div class="max-w-sm mx-auto ..."> 부분
    // Flutter에서는 Scaffold가 이 역할을 담당합니다.
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildMainContent(), // <main> 태그에 해당
      bottomNavigationBar: _buildBottomNavBar(), // <nav id="bottom-nav">에 해당
    );
  }

  // <main id="main-content" ...>
  // 스크롤이 가능하도록 ListView를 사용합니다.
  Widget _buildMainContent() {
    return ListView(
      padding: EdgeInsets.zero, // 전체 화면을 사용하기 위해 기본 패딩 제거
      children: [
        _buildHeader(), // <header id="header">

        // <main>의 px-6 (가로 패딩) 및 space-y-6 (섹션 간 간격)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmotionForecast(), // <section id="emotion-forecast">
              const SizedBox(height: 24), // space-y-6
              _buildAiRoutine(), // <section id="ai-routine">
              const SizedBox(height: 24), // space-y-6
              _buildTodayRecord(), // <section id="today-record">
              const SizedBox(height: 24), // space-y-6
              _buildBodyRhythm(), // <section id="body-rhythm">
            ],
          ),
        ),
        // 하단 네비게이션 바에 가려지지 않도록 여백 추가 (HTML의 <div class="h-20">)
        const SizedBox(height: 40),
      ],
    );
  }

  // <header id="header" class="px-6 pt-12 pb-6">
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '유진님, 오늘의 감정 예보를\n알려드릴게요 ☀️',
            style: TextStyle(
              fontSize: 20, // text-xl
              fontWeight: FontWeight.w500, // font-medium
              color: AuraColors.gray800,
              height: 1.5, // leading-relaxed
            ),
          ),
          const SizedBox(height: 8), // mt-2
          Text(
            'AI가 당신의 주기와 최근 패턴을 분석했어요.',
            style: TextStyle(
              fontSize: 14, // text-sm
              color: AuraColors.gray500,
            ),
          ),
        ],
      ),
    );
  }

  // <section id="emotion-forecast" ...>
  Widget _buildEmotionForecast() {
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        gradient: const LinearGradient(
          // bg-gradient-to-br
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AuraColors.lavender, // from-lavender
            AuraColors.pinkEnd, // to-pink-end
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 부분
          const Text(
            '오늘의 감정 예보',
            style: TextStyle(
              fontSize: 18, // text-lg
              fontWeight: FontWeight.w500, // font-medium
              color: AuraColors.gray800,
            ),
          ),
          const Text(
            'AI 기반 개인 맞춤 예측',
            style: TextStyle(
              fontSize: 14, // text-sm
              color: AuraColors.gray600,
            ),
          ),
          const SizedBox(height: 16), // mb-4

          // <div class="grid grid-cols-3 gap-3 ...">
          Row(
            children: [
              _buildForecastCard('☀️', '기분', '좋음'),
              const SizedBox(width: 12), // gap-3
              _buildForecastCard('☁️', 'PMS 위험', '낮음'),
              const SizedBox(width: 12), // gap-3
              _buildForecastCard('⚡', '에너지', '높음'),
            ],
          ),
          const SizedBox(height: 16), // mb-4

          // <p class="text-sm text-gray-700 bg-white/40 ...">
          Container(
            padding: const EdgeInsets.all(12), // p-3
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4), // bg-white/40
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            child: const Text(
              'AI 예보에 따라 오늘은 집중력이 높아요. 중요한 일을 처리하기 좋은 날이에요 🌷',
              style: TextStyle(
                fontSize: 14, // text-sm
                color: AuraColors.gray700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 감정 예보 카드 (반복되는 요소)
  Widget _buildForecastCard(String icon, String title, String value) {
    // Row의 자식이므로 Expanded를 사용해 1/3씩 공간을 차지
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12), // p-3
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6), // bg-white/60
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)), // text-2xl
            const SizedBox(height: 4), // mb-1
            Text(
              title,
              style: const TextStyle(
                fontSize: 12, // text-xs
                fontWeight: FontWeight.w500, // font-medium
                color: AuraColors.gray700,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12, // text-xs
                color: AuraColors.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // <section id="ai-routine" ...>
  Widget _buildAiRoutine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 부분
        const Text(
          '오늘의 맞춤 루틴',
          style: TextStyle(
            fontSize: 18, // text-lg
            fontWeight: FontWeight.w500, // font-medium
            color: AuraColors.gray800,
          ),
        ),
        const Text(
          'AI가 오늘의 감정 예보에 맞는 루틴을 추천드려요.',
          style: TextStyle(
            fontSize: 14, // text-sm
            color: AuraColors.gray600,
          ),
        ),
        const SizedBox(height: 16), // space-y-4

        // <div class="space-y-3">
        _buildRoutineItem('☕', '따뜻한 차 마시기', isCompleted: false),
        const SizedBox(height: 12), // space-y-3
        _buildRoutineItem('🧘', '10분 스트레칭', isCompleted: true),
        const SizedBox(height: 12), // space-y-3
        _buildRoutineItem('📵', '디지털 디톡스', isCompleted: false),
      ],
    );
  }

  // 맞춤 루틴 아이템 (반복되는 요소)
  Widget _buildRoutineItem(String icon, String title,
      {bool isCompleted = false}) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AuraColors.gray100), // border border-gray-100
        borderRadius: BorderRadius.circular(16), // rounded-2xl
      ),
      // flex items-center justify-between
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // flex items-center space-x-3
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)), // text-xl
              const SizedBox(width: 12), // space-x-3
              Text(
                title,
                style: const TextStyle(
                  color: AuraColors.gray800,
                  fontWeight: FontWeight.w500, // font-medium
                ),
              ),
            ],
          ),
          // 버튼 (완료 여부에 따라 분기)
          isCompleted
              ? _buildGrayButton() // 완료됨 버튼
              : _buildPinkButton(), // 시작하기 버튼
        ],
      ),
    );
  }

  // '시작하기' 핑크 그라데이션 버튼
  Widget _buildPinkButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AuraColors.lightPink, AuraColors.primaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8), // rounded-lg
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // 그라데이션을 위해 투명 처리
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // px-4 py-2
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          '시작하기',
          style: TextStyle(
            fontSize: 14, // text-sm
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // '완료됨' 회색 버튼
  Widget _buildGrayButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AuraColors.gray100, // bg-gray-100
        foregroundColor: AuraColors.gray600, // text-gray-600
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // px-4 py-2
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // rounded-lg
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        '완료됨',
        style: TextStyle(fontSize: 14), // text-sm
      ),
    );
  }

  // <section id="today-record" ...>
  Widget _buildTodayRecord() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘의 기록',
          style: TextStyle(
            fontSize: 18, // text-lg
            fontWeight: FontWeight.w500, // font-medium
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 16), // space-y-4

        // <div class="flex space-x-3 overflow-x-auto ...">
        // 가로 스크롤 영역
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRecordChip('😴', '수면', '7시간'),
              const SizedBox(width: 12), // space-x-3
              _buildRecordChip('😊', '감정', '3회'),
              const SizedBox(width: 12), // space-x-3
              _buildRecordChip('🍽️', '식사', '2회'),
              const SizedBox(width: 12), // space-x-3
              _buildRecordChip('🏃', '운동', '1회'),
              const SizedBox(width: 12), // space-x-3
              _buildRecordChip('💧', '수분', '1.2L'),
            ],
          ),
        ),
        const SizedBox(height: 16), // 버튼 위 여백 (HTML에는 없지만 구성을 위해 추가)

        // <button class="w-full bg-primary-pink ...">
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AuraColors.primaryPink, // bg-primary-pink
            foregroundColor: Colors.white, // text-white
            minimumSize: const Size(double.infinity, 48), // w-full, py-3
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // rounded-2xl
            ),
            elevation: 0,
          ),
          child: const Text(
            '오늘 기록하기 (60% 완료)',
            style: TextStyle(
              fontWeight: FontWeight.w500, // font-medium
            ),
          ),
        ),
      ],
    );
  }

  // '오늘의 기록' 가로 스크롤 칩 (반복되는 요소)
  Widget _buildRecordChip(String icon, String title, String value) {
    return Container(
      width: 80, // min-w-[80px]
      padding: const EdgeInsets.all(12), // p-3
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AuraColors.gray100),
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)), // text-lg
          const SizedBox(height: 4), // mb-1
          Text(
            title,
            style: const TextStyle(
              fontSize: 12, // text-xs
              color: AuraColors.gray600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12, // text-xs
              fontWeight: FontWeight.w500, // font-medium
              color: AuraColors.gray800,
            ),
          ),
        ],
      ),
    );
  }

  // <section id="body-rhythm" ...>
  Widget _buildBodyRhythm() {
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: AuraColors.gray50, // bg-gray-50
        borderRadius: BorderRadius.circular(16), // rounded-2xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 몸 리듬 요약',
            style: TextStyle(
              fontSize: 18, // text-lg
              fontWeight: FontWeight.w500, // font-medium
              color: AuraColors.gray800,
            ),
          ),
          const SizedBox(height: 16), // space-y-4

          // <div class="flex items-center justify-between">
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // <div class="flex-1">
              const Expanded(
                child: Text(
                  '배란기 D-2 · 피로 주의 🎉\n다음 생리 예정일까지 14일',
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    color: AuraColors.gray700,
                    height: 1.5,
                  ),
                ),
              ),
              // <div class="relative w-16 h-16">
              // SVG 원형 프로그레스 바 -> Stack + CircularProgressIndicator
              SizedBox(
                width: 64, // w-16
                height: 64, // h-16
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.5, // 50% (stroke-dasharray="50, 100")
                      backgroundColor: AuraColors.gray200, // text-gray-200
                      color: AuraColors.primaryPink, // text-primary-pink
                      strokeWidth: 5, // stroke-width="3" (Flutter는 픽셀이 좀 더 굵어야 비슷)
                    ),
                    const Text(
                      '50%',
                      style: TextStyle(
                        fontSize: 12, // text-xs
                        fontWeight: FontWeight.w500, // font-medium
                        color: AuraColors.gray700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // space-y-4

          // <button class="w-full bg-gradient-to-r ...">
          // 핑크 그라데이션 버튼 (재사용)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AuraColors.lightPink, AuraColors.primaryPink],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16), // rounded-2xl
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12), // py-3
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // rounded-2xl
                ),
              ),
              child: const Text(
                'AI 예보 참고하기',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500, // font-medium
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // <nav id="bottom-nav" ...>
  Widget _buildBottomNavBar() {
    // BottomAppBar를 사용해 네비게이션 바 구현
    return BottomAppBar(
      color: Colors.white,
      elevation: 4, // border-t border-gray-100 (그림자로 대체)
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // flex justify-between items-center
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(FontAwesomeIcons.house, '홈', isActive: true),
            _buildNavItem(FontAwesomeIcons.calendar, '기록'),
            _buildNavItem(FontAwesomeIcons.robot, 'AI 루틴'),
            _buildNavItem(FontAwesomeIcons.chartLine, 'AI 리포트'),
            _buildNavItem(FontAwesomeIcons.user, '마이'),
          ],
        ),
      ),
    );
  }

  // 하단 네비게이션 아이템 (반복되는 요소)
  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    final Color color = isActive ? AuraColors.primaryPink : AuraColors.gray400;

    // flex flex-col items-center space-y-1
    return Column(
      mainAxisSize: MainAxisSize.min, // <div>의 크기를 자식에 맞춤
      children: [
        Icon(icon, color: color, size: 20), // text-lg
        const SizedBox(height: 4), // space-y-1
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12, // text-xs
          ),
        ),
      ],
    );
  }
}