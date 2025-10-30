import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart'; // 🌟 차트 라이브러리 import
import '../../utils/aura_colors.dart'; 

class AiReportScreen extends StatelessWidget {
  const AiReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HTML의 body 배경 그라데이션
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FF), // from-pink-50 to-purple-50 유사색
      body: buildMainContent(),
    );
  }

  // 메인 스크롤 영역
  Widget buildMainContent() {
    return ListView(
      padding: EdgeInsets.zero, // 상단 여백 제거
      children: [
        buildHeader(), // 리포트 헤더
        buildAiSummary(), // AI 주간 요약
        buildEmotionTrend(), // 감정 변화 그래프
        buildSleepRhythm(), // 수면 & 리듬 요약
        buildDietRoutine(), // 식습관 & 루틴 요약
        buildAiInsight(), // AI 통찰
        buildEmotionalFeedback(), // 감성 피드백
        buildMonthlyReport(), // 월간 리포트
        const SizedBox(height: 40), // 하단 추가 여백
      ],
    );
  }

  // <div id="header">
  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 16), // px-6 pt-12 pb-4
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '리포트',
            style: TextStyle(
              fontSize: 24, // text-2xl
              fontWeight: FontWeight.bold, // font-bold
              color: AuraColors.gray800,
            ),
          ),
          const FaIcon(
            FontAwesomeIcons.calendarWeek, // fa-calendar-week
            color: AuraColors.gray500,
            size: 20, // text-xl
          ),
        ],
      ),
    );
  }

  // <div id="ai-summary">
  Widget buildAiSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // px-6 mb-6
      child: Container(
        padding: const EdgeInsets.all(24), // p-6
        decoration: BoxDecoration(
          gradient: reportPinkGradient, // gradient-pink
          borderRadius: BorderRadius.circular(24), // rounded-3xl
          boxShadow: [
            BoxShadow(
              color: AuraColors.primaryPink.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 이번 주 요약',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.w600, // font-semibold
                    color: AuraColors.gray800,
                  ),
                ),
                Container(
                  width: 40, height: 40, // w-10 h-10
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3), // bg-white/30
                    shape: BoxShape.circle, // rounded-full
                  ),
                  child: const Icon(
                    FontAwesomeIcons.robot, // fa-robot
                    color: AuraColors.pink600, // text-pink-600
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // mb-4
            Text(
              '이번 주는 감정의 기복이 줄고, 피로도가 지난주보다 12% 감소했어요 🌿\n꾸준한 루틴 덕분에 수면 질도 좋아졌어요!',
              style: TextStyle(
                color: AuraColors.gray700,
                height: 1.6, // leading-relaxed
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // <div id="emotion-trend">
  Widget buildEmotionTrend() {
    return buildReportCard(
      title: '감정 변화 추이 그래프',
      subtitle: '이번 주 나의 감정 안정도 변화',
      content: Column(
        children: [
          // 🌟 fl_chart 위젯 사용
          SizedBox(
            height: 192, // h-48
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false, // 세로선 숨김
                  horizontalInterval: 2, // 가로선 간격 (데이터 범위에 맞게 조절)
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AuraColors.gray100, // gridLineColor: #f0f0f0
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  // 하단 라벨 (월~일)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: AuraColors.gray500, fontSize: 12);
                        Widget text;
                        switch (value.toInt()) {
                          case 0: text = const Text('월', style: style); break;
                          case 1: text = const Text('화', style: style); break;
                          case 2: text = const Text('수', style: style); break;
                          case 3: text = const Text('목', style: style); break;
                          case 4: text = const Text('금', style: style); break;
                          case 5: text = const Text('토', style: style); break;
                          case 6: text = const Text('일', style: style); break;
                          default: text = const Text('', style: style); break;
                        }
                        return SideTitleWidget(axisSide: meta.axisSide, child: text);
                      },
                    ),
                  ),
                  // 왼쪽 라벨 (숫자) - 숨김
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  // 위/오른쪽 라벨 숨김
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false), // 테두리 숨김
                minX: 0, maxX: 6, // 월요일(0) ~ 일요일(6)
                minY: 0, maxY: 10, // 감정 점수 범위 (예시)
                lineBarsData: [
                  LineChartBarData(
                    spots: const [ // 예시 데이터 (HTML과 유사하게)
                      FlSpot(0, 6), FlSpot(1, 5), FlSpot(2, 4), 
                      FlSpot(3, 6), FlSpot(4, 7), FlSpot(5, 8), FlSpot(6, 7),
                    ],
                    isCurved: true, // spline
                    color: const Color(0xFFE879F9), // color: '#E879F9'
                    barWidth: 3, // lineWidth: 3
                    isStrokeCapRound: true,
                    dotData: FlDotData( // marker
                      show: true, 
                      getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(radius: 6, color: const Color(0xFFE879F9), strokeWidth: 0),
                    ), 
                    belowBarData: BarAreaData(show: false), // 영역 채우기 없음
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16), // mb-4
          buildInsightBox('수요일부터 에너지가 회복되는 패턴을 보였어요.', AuraColors.purple50),
        ],
      ),
    );
  }
  
  // <div id="sleep-rhythm">
  Widget buildSleepRhythm() {
    return buildReportCard(
      title: '수면 & 신체 리듬 요약',
      content: Column(
        children: [
          buildStatBox(
            gradient: peachGradient,
            label: '평균 수면 시간',
            value: '6시간 45분 💤',
            change: '+30분 ↑',
            changeColor: AuraColors.green600,
          ),
          const SizedBox(height: 12), // space-y-3
          buildStatBox(
            gradient: lavenderGradient,
            label: '기상 시간 일관성',
            value: '82% 유지 ⏰',
          ),
          const SizedBox(height: 12),
          buildStatBox(
            gradient: reportPinkGradient, // gradient-pink
            label: '생리 주기',
            value: '안정기 진입 🌷',
          ),
        ],
      ),
    );
  }

  // <div id="diet-routine">
  Widget buildDietRoutine() {
    return buildReportCard(
      title: '식습관 & 루틴',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row( // 카페인 섭취
            children: [
              const Text('☕', style: TextStyle(fontSize: 24)), // text-2xl
              const SizedBox(width: 12), // space-x-3
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('카페인 섭취: 2회', style: TextStyle(fontWeight: FontWeight.w500, color: AuraColors.gray800)),
                  Text('지난주 대비 40% 감소', style: TextStyle(fontSize: 14, color: AuraColors.green600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16), // space-y-4
          
          // 루틴 실행률
          Column( 
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('루틴 실행률', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AuraColors.gray700)),
                  Text('73% 🎯', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AuraColors.purple600)),
                ],
              ),
              const SizedBox(height: 8), // space-y-2
              Container( // 프로그레스 바
                height: 8, // h-2
                decoration: BoxDecoration(
                  color: AuraColors.gray200,
                  borderRadius: BorderRadius.circular(99), 
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.73, // style="width: 73%"
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      gradient: progressGradient, // from-purple-400 to-pink-400
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // space-y-4
          buildInsightBox("'스트레칭 루틴'이 가장 효과적이었어요.", AuraColors.pink50),
        ],
      ),
    );
  }
  
  // <div id="ai-insight">
  Widget buildAiInsight() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: lavenderGradient, // gradient-lavender
          borderRadius: BorderRadius.circular(24),
          boxShadow: [ BoxShadow(color: AuraColors.lavender.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 5)) ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🤖 AI 통찰', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AuraColors.gray800)),
            const SizedBox(height: 16),
            Text(
              '당신의 감정은 수면 패턴에 크게 영향을 받는 것으로 보여요.\n다음 주엔 취침 시간을 일정하게 유지해보세요.',
              style: TextStyle(color: AuraColors.gray700, height: 1.6, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.5), // bg-white/50
                foregroundColor: AuraColors.purple600, // text-purple-700 (유사색)
                minimumSize: const Size(double.infinity, 48), // w-full py-3
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // rounded-2xl
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('다음 주 추천 루틴 보기', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 8), // space-x-2
                  Icon(FontAwesomeIcons.chevronRight, size: 14), // fa-chevron-right
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // <div id="emotional-feedback">
  Widget buildEmotionalFeedback() {
    return buildReportCard(
      padding: const EdgeInsets.all(24),
      content: Column(
        children: [
          Container( // 🌸 아이콘 서클
            width: 80, height: 80, // w-20 h-20
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient( // from-pink-200 to-purple-200
                colors: [AuraColors.pink200, AuraColors.purple200],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
            child: const Center(child: Text('🌸', style: TextStyle(fontSize: 30))), // text-3xl
          ),
          const SizedBox(height: 16), // mb-4
          Text(
            '이번 주 스스로를 잘 돌보셨어요 🌸\n감정의 흐름은 완벽할 수 없지만,\n꾸준히 기록하는 당신이 가장 멋져요.',
            textAlign: TextAlign.center, // text-center
            style: TextStyle(color: AuraColors.gray700, height: 1.6, fontSize: 14),
          ),
          const SizedBox(height: 24), // mb-6
          ElevatedButton( // 다음 주 기록 시작하기 버튼
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, // 내부 패딩 제거
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: feedbackButtonGradient, // from-pink-400 to-purple-400
                borderRadius: BorderRadius.circular(16), // rounded-2xl
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16), // py-4
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('이전 기록 모아 보기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.arrowRight, size: 14, color: Colors.white), // fa-arrow-right
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // <div id="monthly-report">
  Widget buildMonthlyReport() {
    return buildReportCard(
      title: '이달의 감정 곡선',
      content: Column(
        children: [
           // 🌟 fl_chart 월간 그래프
          SizedBox(
            height: 192, // h-48
            child: LineChart( // areaspline -> LineChart with area
              LineChartData(
                gridData: FlGridData(
                  show: true, drawVerticalLine: false, horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) => const FlLine(color: AuraColors.gray100, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true, reservedSize: 30, interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: AuraColors.gray500, fontSize: 12);
                        Widget text;
                        switch (value.toInt()) {
                          case 0: text = const Text('1주차', style: style); break;
                          case 1: text = const Text('2주차', style: style); break;
                          case 2: text = const Text('3주차', style: style); break;
                          case 3: text = const Text('4주차', style: style); break;
                          default: text = const Text('', style: style); break;
                        }
                        return SideTitleWidget(axisSide: meta.axisSide, child: text);
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0, maxX: 3, minY: 0, maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [ // 예시 데이터
                      FlSpot(0, 6.2), FlSpot(1, 5.8), FlSpot(2, 6.5), FlSpot(3, 7.1),
                    ],
                    isCurved: true,
                    color: const Color(0xFFF472B6), // color: '#F472B6'
                    barWidth: 3, 
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false), // 마커 숨김
                    belowBarData: BarAreaData( // 영역 채우기
                      show: true,
                      gradient: LinearGradient( // fillColor gradient
                        colors: [const Color(0xFFF472B6), const Color(0xFFF472B6).withOpacity(0.1)],
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      ),
                    ), 
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16), // mb-4
          
          // AI 분석 내용들
          Column(
            children: [
              buildInsightBox( // 변화 키워드
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI가 본 당신의 변화 키워드', style: TextStyle(fontWeight: FontWeight.w600, color: AuraColors.gray800)),
                    const SizedBox(height: 8),
                    Wrap( // flex-wrap gap-2
                      spacing: 8, runSpacing: 8,
                      children: [
                        buildKeywordChip('균형', AuraColors.pink200, AuraColors.pink600),
                        buildKeywordChip('회복', AuraColors.purple200, AuraColors.purple600),
                        buildKeywordChip('수면 개선', AuraColors.blue200, AuraColors.blue800),
                      ],
                    ),
                  ],
                ),
                AuraColors.purple50, // bg-purple-50
              ),
              const SizedBox(height: 16), // space-y-4
              buildInsightBox( // 다음 달 예보
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI의 다음 달 예보', style: TextStyle(fontWeight: FontWeight.w600, color: AuraColors.gray800)),
                    const SizedBox(height: 8),
                    Text(
                      '다음 배란기 전후엔 피로감이 예상돼요. 미리 휴식 계획을 세워보세요.',
                      style: TextStyle(fontSize: 14, color: AuraColors.gray700),
                    ),
                  ],
                ),
                Colors.transparent, // 투명 배경
                gradient: peachGradient, // gradient-peach
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 헬퍼 위젯 ---

  // 카드 공통 프레임
  Widget buildReportCard({String? title, String? subtitle, required Widget content, EdgeInsets? padding}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // px-6 mb-6
      child: Container(
        padding: padding ?? const EdgeInsets.all(24), // p-6
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24), // rounded-3xl
          boxShadow: [
            BoxShadow(
              color: AuraColors.gray200.withOpacity(0.7),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) 
              Text(
                title, 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AuraColors.gray800),
              ),
            if (subtitle != null) 
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(subtitle, style: const TextStyle(fontSize: 14, color: AuraColors.gray600)),
              ),
            if (title != null || subtitle != null) 
              const SizedBox(height: 16), // 제목/부제 있으면 간격 추가
            content,
          ],
        ),
      ),
    );
  }

  // 작은 정보 박스 (AI 분석 요약 등)
  Widget buildInsightBox(dynamic textOrWidget, Color bgColor, {LinearGradient? gradient}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12), // p-3
      decoration: BoxDecoration(
        color: gradient == null ? bgColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: textOrWidget is String
        ? Text(textOrWidget, style: const TextStyle(fontSize: 14, color: AuraColors.gray600))
        : textOrWidget, // 위젯이면 그대로 표시
    );
  }

  // 수면 & 리듬 통계 박스
  Widget buildStatBox({required LinearGradient gradient, required String label, required String value, String? change, Color? changeColor}) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16), // rounded-2xl
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AuraColors.gray700)),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AuraColors.gray800)),
            ],
          ),
          if (change != null) 
            Text(change, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: changeColor ?? AuraColors.gray700)),
        ],
      ),
    );
  }

  // 키워드 칩
  Widget buildKeywordChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // px-3 py-1
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(99), // rounded-full
      ),
      child: Text(text, style: TextStyle(fontSize: 14, color: textColor)), // text-sm
    );
  }
}