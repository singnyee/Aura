import 'package:flutter/material.dart';
import '../../utils/aura_colors.dart';
import '../../widgets/aura_next_button.dart';
import 'exercise_record_screen.dart';

class DietRecordScreen extends StatefulWidget {
  const DietRecordScreen({super.key});

  @override
  State<DietRecordScreen> createState() => DietRecordScreenState();
}

class DietRecordScreenState extends State<DietRecordScreen> {
  // 🌟 [수정] 모든 항목이 수량 카운트 방식으로 통일되었습니다.
  Map<String, int> dietData = {
    'salty': 0,    // 0, 1, 2... (접시)
    'caffeine': 0, // 0, 1, 2... (잔)
    'alcohol': 0,  // 0, 1, 2... (잔)
    'sugar': 0,    // 0, 1, 2... (회)
    'fat': 0,      // 0, 1, 2... (회)
    'fruit': 0,    // 0, 1, 2... (개)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: pastelBodyGradient, // EmotionScreen과 동일한 배경
        ),
        child: buildMainContent(),
      ),
      bottomNavigationBar: AuraNextButton(
        onPressed: () {
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

  Widget buildMainContent() {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 48),
            buildProgressBar(),
            const SizedBox(height: 24),
            buildHeaderTitle(),
            const SizedBox(height: 24),
            buildDietCard(
              '짠 음식 🧂',
              '나트륨 섭취량을 알려주세요.',
              buildCounterInput('salty', '접시'),
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '카페인 ☕',
              '커피, 차, 에너지 드링크 등을 드셨나요?',
              buildCounterInput('caffeine', '잔'),
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '음주 🍺',
              '음주를 하셨나요?',
              buildCounterInput('alcohol', '잔'),
            ),
            const SizedBox(height: 24),
            
            // 🌟 [수정] 5단계 버튼 UI에서 수량 카운터 UI로 변경
            buildDietCard(
              '단순당/정제 탄수화물 🍰',
              '디저트, 빵, 과자, 음료수 등을 드셨나요?',
              buildCounterInput('sugar', '회'), // 🌟 수량 카운터 UI
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '지방 🥓',
              '튀김, 기름진 고기 등 포화/트랜스 지방을 드셨나요?',
              buildCounterInput('fat', '접시'), // 🌟 수량 카운터 UI
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '과일 🍓',
              '과일 섭취량을 알려주세요.',
              buildCounterInput('fruit', '개'), // 🌟 수량 카운터 UI
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // EmotionScreen과 동일한 스타일 (왼쪽 정렬, softGradient)
  Widget buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step 2 of 5',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AuraColors.gray600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.4, // 40%
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: softGradient,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // EmotionScreen과 동일한 스타일 (왼쪽 정렬, 폰트 스타일)
  Widget buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 식습관을 기록해 주세요 🍽️',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '섭취한 음식은 감정 예보에 영향을 줘요.',
          style: TextStyle(
            fontSize: 14,
            color: AuraColors.gray600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // 카드의 구조를 재사용하고, 입력 UI(child)를 파라미터로 받음
  Widget buildDietCard(
    String title,
    String subtitle,
    Widget child, // 입력 UI를 직접 받음
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.gray100),
        boxShadow: [
          BoxShadow(
            color: AuraColors.gray50.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
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
          child, // 🌟 여기에 수량 카운터가 들어옴
        ],
      ),
    );
  }

  // 🌟 [삭제됨] 
  // 헬퍼 위젯: 5단계 선택 UI (buildScaleInput)

  // 🌟 [삭제됨]
  // 헬퍼 위젯: 5단계 선택 버튼 (buildScaleButton)

  // 헬퍼 위젯: 수량 카운터 UI
  Widget buildCounterInput(String dietKey, String unit) {
    int count = dietData[dietKey] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // '-' 빼기 버튼
        buildCounterButton(
          Icons.remove,
          count > 0 ? () { // 0보다 클 때만 활성화
            setState(() {
              dietData[dietKey] = (count - 1).clamp(0, 99);
            });
          } : null, // null이면 비활성화
        ),
        // 수량 텍스트
        SizedBox(
          width: 100, // 텍스트 영역 고정 폭
          child: Text(
            '$count $unit',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AuraColors.gray800,
            ),
          ),
        ),
        // '+' 더하기 버튼
        buildCounterButton(
          Icons.add,
          () { // 항상 활성화 (99에서 멈춤)
            setState(() {
              dietData[dietKey] = (count + 1).clamp(0, 99);
            });
          },
        ),
      ],
    );
  }

  // 헬퍼 위젯: 수량 카운터 버튼
  Widget buildCounterButton(IconData icon, VoidCallback? onPressed) {
    bool isEnabled = onPressed != null;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(99), // 물결 효과를 원형으로
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled ? AuraColors.gray100 : AuraColors.gray50,
          shape: BoxShape.circle, // 원형 버튼
        ),
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ? AuraColors.gray700 : AuraColors.gray200,
        ),
      ),
    );
  }
}