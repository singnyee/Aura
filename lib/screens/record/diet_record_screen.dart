import 'package:flutter/material.dart';
import '../../utils/aura_colors.dart'; // 공통 색상 파일

// SleepRecordScreen에서 사용한 그라데이션을 동일하게 가져옵니다.
const LinearGradient pinkGradient = LinearGradient(
  colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient lavenderGradient = LinearGradient(
  colors: [Color(0xFFE8E0F7), Color(0xFFDDD0F0)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class DietRecordScreen extends StatefulWidget {
  const DietRecordScreen({super.key});

  @override
  State<DietRecordScreen> createState() => DietRecordScreenState();
}

class DietRecordScreenState extends State<DietRecordScreen> {
  // 6가지 항목의 선택 상태를 관리합니다. (0: 안 먹음, 1: 보통, 2: 많이)
  Map<String, int> dietSelections = {
    'salty': 0,
    'caffeine': 0,
    'alcohol': 0,
    'sugar': 0,
    'fat': 0,
    'fruit': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FF), // 동일한 배경색
      body: buildMainContent(),
      bottomNavigationBar: buildFooter(),
    );
  }

  Widget buildMainContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        const SizedBox(height: 48), // pt-12
        buildProgressBar(), // 40%로 수정된 프로그레스 바
        const SizedBox(height: 24), // mb-6
        buildHeaderTitle(), // 새로운 제목
        const SizedBox(height: 24), // space-y-6

        // 6가지 식습관 카드
        buildDietCard(
          'salty',
          '짠 음식 🧂',
          '나트륨 섭취량을 알려주세요.',
          pinkGradient,
        ),
        const SizedBox(height: 24),
        buildDietCard(
          'caffeine',
          '카페인 ☕',
          '커피, 차, 에너지 드링크 등을 드셨나요?',
          lavenderGradient,
        ),
        const SizedBox(height: 24),
        buildDietCard(
          'alcohol',
          '음주 🍺',
          '음주를 하셨나요?',
          pinkGradient,
        ),
        const SizedBox(height: 24),
        buildDietCard(
          'sugar',
          '단순당/정제 탄수화물 🍰',
          '디저트, 빵, 과자, 음료수 등을 드셨나요?',
          lavenderGradient,
        ),
        const SizedBox(height: 24),
        buildDietCard(
          'fat',
          '지방 🥓',
          '튀김, 기름진 고기 등 포화/트랜스 지방을 드셨나요?',
          pinkGradient,
        ),
        const SizedBox(height: 24),
        buildDietCard(
          'fruit',
          '과일 🍓',
          '과일 섭취량을 알려주세요.',
          lavenderGradient,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // 40% (Step 2 of 5)로 수정된 프로그레스 바
  Widget buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 2 of 5', // 🌟 수정
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuraColors.gray600,
              ),
            ),
            Text(
              '40%', // 🌟 수정
              style: TextStyle(
                fontSize: 14,
                color: AuraColors.primaryPink.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // mb-2
        Container(
          height: 8, // h-2
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99), // rounded-full
          ),
          child: FractionallySizedBox(
            widthFactor: 0.4, // 🌟 수정 (style="width: 40%")
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: pinkGradient, // gradient-pink
              ),
            ),
          ),
        ),
      ],
    );
  }

  // '식습관 기록'에 맞게 수정된 헤더
  Widget buildHeaderTitle() {
    return Column(
      children: [
        Text(
          '오늘의 식습관을 기록해 주세요 🍽️', // 🌟 수정
          style: TextStyle(
            fontSize: 22, // text-2xl
            fontWeight: FontWeight.w600, // font-semibold
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 8), // mb-2
        Text(
          '섭취한 음식은 감정 예보에 영향을 줘요.', // 🌟 수정
          style: TextStyle(
            fontSize: 14, // text-sm
            color: AuraColors.gray600,
            height: 1.5, // leading-relaxed
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // 식습관 선택 카드 (재사용 위젯)
  Widget buildDietCard(
    String dietKey, // 'salty', 'caffeine' 등
    String title,
    String subtitle,
    LinearGradient gradient,
  ) {
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // bg-white/80
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        border: Border.all(color: AuraColors.lightPink.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AuraColors.lightPink.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 좌측 정렬
        children: [
          // 카드 헤더 (제목 + 부제목)
          Text(
            title,
            style: const TextStyle(
              fontSize: 18, // text-lg
              fontWeight: FontWeight.w500, // font-medium
              color: AuraColors.gray800,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: AuraColors.gray600,
            ),
          ),
          const SizedBox(height: 16), // mb-4

          // 3단계 선택 버튼 (가로 배치)
          Row(
            children: [
              buildChoiceButton(dietKey, 0, '안 먹음'),
              const SizedBox(width: 12),
              buildChoiceButton(dietKey, 1, '보통'),
              const SizedBox(width: 12),
              buildChoiceButton(dietKey, 2, '많이'),
            ],
          ),
        ],
      ),
    );
  }

  // '안 먹음', '보통', '많이' 선택 버튼 (재사용 위젯)
  Widget buildChoiceButton(String dietKey, int value, String text) {
    // 현재 선택된 값과 이 버튼의 값이 일치하는지 확인
    bool isSelected = dietSelections[dietKey] == value;

    // Row의 자식이므로 Expanded로 1/3씩 공간 차지
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 버튼을 누르면 해당 항목의 상태 값을 이 버튼의 value로 변경
            dietSelections[dietKey] = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12), // py-3
          decoration: BoxDecoration(
            // 선택되면 핑크 그라데이션, 아니면 회색
            gradient: isSelected ? pinkGradient : null,
            color: isSelected ? null : AuraColors.gray100,
            borderRadius: BorderRadius.circular(12), // rounded-xl
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? AuraColors.gray700 : AuraColors.gray600,
            ),
          ),
        ),
      ),
    );
  }

  // '다음으로' 버튼
  Widget buildFooter() {
    return BottomAppBar(
      color: Colors.transparent, // 배경을 투명하게
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: pinkGradient,
            borderRadius: BorderRadius.circular(16), // rounded-2xl
            boxShadow: [
              BoxShadow(
                color: AuraColors.primaryPink.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              // 다음 페이지 (운동 기록)로 이동하는 로직
              // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseRecordScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16), // py-4
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              '다음으로 →',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600, // font-semibold
                fontSize: 18, // text-lg
              ),
            ),
          ),
        ),
      ),
    );
  }
}