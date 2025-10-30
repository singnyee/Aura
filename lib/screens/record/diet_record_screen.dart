import 'package:flutter/material.dart';
import '../../utils/aura_colors.dart'; 
// 🌟 1. [추가] 새로 만든 공통 버튼을 import 합니다.
import '../../widgets/aura_next_button.dart';
import 'exercise_record_screen.dart'; 

// 🌟 2. [삭제] 
// 아래에 있던 const LinearGradient pinkGradient...
// const LinearGradient lavenderGradient... 2줄이 삭제되었습니다.
// (공통 파일인 aura_colors.dart 로 이동했기 때문입니다)

class DietRecordScreen extends StatefulWidget {
  const DietRecordScreen({super.key});

  @override
  State<DietRecordScreen> createState() => DietRecordScreenState();
}

class DietRecordScreenState extends State<DietRecordScreen> {
  Map<String, int> dietSelections = {
    'salty': 0,
    'caffeine': 0,
    'alcohol': 0,
    'sugar': 0,
    'fat': 0,
    'fruit': 0,
  };

  // 🌟 3. [수정] 
  // build 메서드만 수정되었습니다.
  // buildFooter()를 호출하는 대신, AuraNextButton 위젯을
  // bottomNavigationBar에 직접 넣어줍니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FF), 
      body: buildMainContent(),
      // 🌟 3-1. [수정] bottomNavigationBar 속성을 수정합니다.
      bottomNavigationBar: AuraNextButton(
        // 🌟 2. [수정] '다음으로' 버튼을 눌렀을 때의 동작을 수정합니다.
        onPressed: () {
          // '운동 기록' 화면으로 이동하는 로직을 추가합니다.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExerciseRecordScreen(),
            ),
          );
        },
      ),
    );
  }

  //
  // (이 아래 buildMainContent, buildProgressBar, buildHeaderTitle, 
  //  buildDietCard, buildChoiceButton 메서드는
  //  전혀 수정하지 않았습니다. 그대로 두시면 됩니다.)
  //

  Widget buildMainContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        const SizedBox(height: 48), 
        buildProgressBar(), 
        const SizedBox(height: 24), 
        buildHeaderTitle(), 
        const SizedBox(height: 24), 

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
        const SizedBox(height: 120), // 하단 여백
      ],
    );
  }

  Widget buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 2 of 5', 
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuraColors.gray600,
              ),
            ),
            Text(
              '40%', 
              style: TextStyle(
                fontSize: 14,
                color: AuraColors.primaryPink.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), 
        Container(
          height: 8, 
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99), 
          ),
          child: FractionallySizedBox(
            widthFactor: 0.4, 
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: pinkGradient, 
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeaderTitle() {
    return Column(
      children: [
        Text(
          '오늘의 식습관을 기록해 주세요 🍽️', 
          style: TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600, 
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 8), 
        Text(
          '섭취한 음식은 감정 예보에 영향을 줘요.', 
          style: TextStyle(
            fontSize: 14, 
            color: AuraColors.gray600,
            height: 1.5, 
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildDietCard(
    String dietKey, 
    String title,
    String subtitle,
    LinearGradient gradient,
  ) {
    return Container(
      padding: const EdgeInsets.all(24), 
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: AuraColors.lightPink.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AuraColors.lightPink.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w500, 
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
          const SizedBox(height: 16), 

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

  Widget buildChoiceButton(String dietKey, int value, String text) {
    bool isSelected = dietSelections[dietKey] == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            dietSelections[dietKey] = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12), 
          decoration: BoxDecoration(
            gradient: isSelected ? pinkGradient : null,
            color: isSelected ? null : AuraColors.gray100,
            borderRadius: BorderRadius.circular(12), 
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

  // 🌟 4. [삭제] 
  // 이 파일의 맨 아래에 있던 
  // Widget buildFooter() { ... } 메서드 전체가 삭제되었습니다.
}