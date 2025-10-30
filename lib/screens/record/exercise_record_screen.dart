import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import '../../utils/aura_colors.dart'; 
import '../../widgets/aura_next_button.dart';
import 'emotion_record_screen.dart'; 

class ExerciseRecordScreen extends StatefulWidget {
  const ExerciseRecordScreen({super.key});

  @override
  State<ExerciseRecordScreen> createState() => ExerciseRecordScreenState();
}

class ExerciseRecordScreenState extends State<ExerciseRecordScreen> {
  int intenseRun = 0; 
  int strengthTraining = 0; 
  int stretching = 0; 
  
  final TextEditingController stepsController = TextEditingController();

  @override
  void dispose() {
    stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FF), 
      body: buildMainContent(),
      bottomNavigationBar: AuraNextButton(
        onPressed: () {
          // '감정 기록' 화면으로 이동하는 로직을 추가합니다.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmotionRecordScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget buildMainContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        const SizedBox(height: 48), 
        buildProgressBar(), 
        const SizedBox(height: 24), 
        buildHeaderTitle(), 
        const SizedBox(height: 24), 

        // 🌟 1. [수정] '격렬한 달리기' 카드
        // buildTwoChoiceButton에 onTap 로직을 직접 전달합니다.
        buildQuestionCard(
          title: '격렬한 달리기 💨',
          subtitle: '심장이 빠르게 뛸 정도로 달렸나요?',
          gradient: pinkGradient,
          child: Row(
            children: [
              buildTwoChoiceButton(
                stateValue: intenseRun, 
                buttonValue: 1, 
                text: '예',
                onTap: () { // 👈 '예'를 눌렀을 때 실행할 함수
                  setState(() { intenseRun = 1; });
                }
              ),
              const SizedBox(width: 12),
              buildTwoChoiceButton(
                stateValue: intenseRun, 
                buttonValue: 0, 
                text: '아니요',
                onTap: () { // 👈 '아니요'를 눌렀을 때 실행할 함수
                  setState(() { intenseRun = 0; });
                }
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        buildQuestionCard(
          title: '총 걸음수 👟',
          subtitle: '오늘 총 몇 걸음을 걸으셨나요?',
          gradient: lavenderGradient,
          child: buildStepsInput(), 
        ),
        const SizedBox(height: 24),

        buildQuestionCard(
          title: '근력 운동 💪',
          subtitle: '오늘 근력 운동을 하셨나요?',
          gradient: pinkGradient,
          child: Row(
            children: [
              buildThreeChoiceButton(strengthTraining, 0, '안 함'),
              const SizedBox(width: 12),
              buildThreeChoiceButton(strengthTraining, 1, '30분 미만'),
              const SizedBox(width: 12),
              buildThreeChoiceButton(strengthTraining, 2, '30분 이상'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 🌟 2. [수정] '스트레칭' 카드
        // buildTwoChoiceButton에 onTap 로직을 직접 전달합니다.
        buildQuestionCard(
          title: '스트레칭 🧘‍♀️',
          subtitle: '오늘 스트레칭을 하셨나요?',
          gradient: lavenderGradient,
          child: Row(
            children: [
              buildTwoChoiceButton(
                stateValue: stretching, 
                buttonValue: 1, 
                text: '예',
                onTap: () { // 👈 '예'를 눌렀을 때 실행할 함수
                  setState(() { stretching = 1; });
                }
              ),
              const SizedBox(width: 12),
              buildTwoChoiceButton(
                stateValue: stretching, 
                buttonValue: 0, 
                text: '아니요',
                onTap: () { // 👈 '아니요'를 눌렀을 때 실행할 함수
                  setState(() { stretching = 0; });
                }
              ),
            ],
          ),
        ),

        const SizedBox(height: 120), 
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
              'Step 3 of 5', 
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuraColors.gray600,
              ),
            ),
            Text(
              '60%', 
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
            widthFactor: 0.6, 
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
          '오늘의 운동을 기록해 주세요 🏃‍♀️', 
          style: TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600, 
            color: AuraColors.gray800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8), 
        Text(
          '신체 활동은 AI 예보의 정확도를 높여줘요.', 
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

  Widget buildQuestionCard({
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required Widget child,
  }) {
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
          child, 
        ],
      ),
    );
  }

  Widget buildStepsInput() {
    return TextField(
      controller: stepsController,
      keyboardType: TextInputType.number, 
      inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
      decoration: InputDecoration(
        hintText: '0',
        suffixText: '걸음',
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        hintStyle: const TextStyle(color: AuraColors.gray500),
        suffixStyle: const TextStyle(color: AuraColors.gray700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFDE6E9), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFDE6E9), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AuraColors.primaryPink, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AuraColors.gray700,
      ),
      textAlign: TextAlign.right,
    );
  }

  // 🌟 3. [수정] '예' / '아니요' (2개) 버튼 위젯
  // 'title' 변수를 제거하고, 'onTap' 함수를 받도록 수정합니다.
  Widget buildTwoChoiceButton({
    required int stateValue, 
    required int buttonValue, 
    required String text,
    required VoidCallback onTap, // 👈 [수정] 행동을 직접 받음
  }) {
    bool isSelected = (stateValue == buttonValue);

    return Expanded(
      child: GestureDetector(
        onTap: onTap, // 👈 [수정] 전달받은 onTap 함수를 실행
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

  Widget buildThreeChoiceButton(int stateValue, int buttonValue, String text) {
    bool isSelected = (stateValue == buttonValue);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            strengthTraining = buttonValue; 
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
              fontSize: (text == '30분 미만' || text == '30분 이상') ? 12 : 14, 
            ),
          ),
        ),
      ),
    );
  }
}