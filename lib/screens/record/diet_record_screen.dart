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
  Map<String, int> dietData = {
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: pastelBodyGradient,
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
            buildDietCard(
              '단순당/정제 탄수화물 🍰',
              '디저트, 빵, 과자, 음료수 등을 드셨나요?',
              buildCounterInput('sugar', '회'),
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '지방 🥓',
              '튀김, 기름진 고기 등 포화/트랜스 지방을 드셨나요?',
              buildCounterInput('fat', '회'),
            ),
            const SizedBox(height: 24),
            buildDietCard(
              '과일 🍓',
              '과일 섭취량을 알려주세요.',
              buildCounterInput('fruit', '개'),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

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

  Widget buildDietCard(
    String title,
    String subtitle,
    Widget child,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // 🌟 [수정] 테두리 두께 (width) 2.0으로 증가
        border: Border.all(color: AuraColors.gray200, width: 3.0),
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
          child,
        ],
      ),
    );
  }

  Widget buildCounterInput(String dietKey, String unit) {
    int count = dietData[dietKey] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildCounterButton(
          Icons.remove,
          count > 0 ? () {
            setState(() {
              dietData[dietKey] = (count - 1).clamp(0, 99);
            });
          } : null,
        ),
        SizedBox(
          width: 100,
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
        buildCounterButton(
          Icons.add,
          () {
            setState(() {
              dietData[dietKey] = (count + 1).clamp(0, 99);
            });
          },
        ),
      ],
    );
  }

  Widget buildCounterButton(IconData icon, VoidCallback? onPressed) {
    bool isEnabled = onPressed != null;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(99),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled ? AuraColors.gray200 : AuraColors.gray100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ? AuraColors.gray700 : AuraColors.gray400,
        ),
      ),
    );
  }
}