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
      // 🌟 [수정] EmotionScreen과 동일하게 변경
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: pastelBodyGradient,
        ),
        child: buildMainContent(),
      ),
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

  // 🌟 [수정] EmotionScreen과 동일한 흰색 컨테이너 + SafeArea 래퍼 적용
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
            buildProgressBar(), // 🌟 [수정됨]
            const SizedBox(height: 24),
            buildHeaderTitle(), // 🌟 [수정됨]
            const SizedBox(height: 24),

            // 🌟 [수정] '격렬한 달리기' 카드
            // gradient 파라미터 제거
            buildQuestionCard(
              title: '격렬한 달리기 💨',
              subtitle: '심장이 빠르게 뛸 정도로 달렸나요?',
              // gradient: pinkGradient, // 🌟 [삭제]
              child: Row(
                children: [
                  buildTwoChoiceButton(
                      stateValue: intenseRun,
                      buttonValue: 1,
                      text: '예',
                      onTap: () {
                        setState(() {
                          intenseRun = 1;
                        });
                      }),
                  const SizedBox(width: 12),
                  buildTwoChoiceButton(
                      stateValue: intenseRun,
                      buttonValue: 0,
                      text: '아니요',
                      onTap: () {
                        setState(() {
                          intenseRun = 0;
                        });
                      }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            buildQuestionCard(
              title: '총 걸음수 👟',
              subtitle: '오늘 총 몇 걸음을 걸으셨나요?',
              // gradient: lavenderGradient, // 🌟 [삭제]
              child: buildStepsInput(),
            ),
            const SizedBox(height: 24),

            buildQuestionCard(
              title: '근력 운동 💪',
              subtitle: '오늘 근력 운동을 하셨나요?',
              // gradient: pinkGradient, // 🌟 [삭제]
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

            // 🌟 [수정] '스트레칭' 카드
            // gradient 파라미터 제거
            buildQuestionCard(
              title: '스트레칭 🧘‍♀️',
              subtitle: '오늘 스트레칭을 하셨나요?',
              // gradient: lavenderGradient, // 🌟 [삭제]
              child: Row(
                children: [
                  buildTwoChoiceButton(
                      stateValue: stretching,
                      buttonValue: 1,
                      text: '예',
                      onTap: () {
                        setState(() {
                          stretching = 1;
                        });
                      }),
                  const SizedBox(width: 12),
                  buildTwoChoiceButton(
                      stateValue: stretching,
                      buttonValue: 0,
                      text: '아니요',
                      onTap: () {
                        setState(() {
                          stretching = 0;
                        });
                      }),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // 🌟 [수정] EmotionScreen과 동일한 스타일 (왼쪽 정렬, softGradient)로 변경
  Widget buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 🌟 왼쪽 정렬
      children: [
        Text(
          'Step 3 of 5', // 내용은 ExerciseScreen 값 유지
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AuraColors.gray600,
          ),
        ),
        const SizedBox(height: 12), // 🌟 EmotionScreen과 간격 통일
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.6, // 내용은 ExerciseScreen 값 유지 (60%)
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: softGradient, // 🌟 EmotionScreen과 색상 통일
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🌟 [수정] EmotionScreen과 동일한 스타일 (왼쪽 정렬, 폰트 스타일)로 변경
  Widget buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 🌟 왼쪽 정렬
      children: [
        Text(
          '오늘의 운동을 기록해 주세요 🏃‍♀️', // 내용은 ExerciseScreen 값 유지
          style: TextStyle(
            fontSize: 20, // 🌟 EmotionScreen과 폰트 통일
            fontWeight: FontWeight.w600, // 🌟 EmotionScreen과 폰트 통일
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 12), // 🌟 EmotionScreen과 간격 통일
        Text(
          '신체 활동은 AI 예보의 정확도를 높여줘요.', // 내용은 ExerciseScreen 값 유지
          style: TextStyle(
            fontSize: 14,
            color: AuraColors.gray600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // 🌟 [수정] EmotionScreen/DietScreen과 동일한 카드 디자인 적용
  Widget buildQuestionCard({
    required String title,
    required String subtitle,
    // required LinearGradient gradient, // 🌟 [삭제]
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      // 🌟 [수정] EmotionScreen의 buildQuestionCard와 동일한 카드 디자인 적용
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
        // 🌟 [수정] 카드 배경이 흰색이므로 입력 필드 배경도 흰색으로
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: AuraColors.gray500),
        suffixStyle: const TextStyle(color: AuraColors.gray700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // 🌟 [수정] 기본 보더 색상 통일 (gray200)
          borderSide: const BorderSide(color: AuraColors.gray200, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // 🌟 [수정] 활성 보더 색상 통일 (gray200)
          borderSide: const BorderSide(color: AuraColors.gray200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // 🌟 [수정] 포커스 보더 색상 통일 (softPink)
          borderSide: const BorderSide(color: AuraColors.softPink, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AuraColors.gray700,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget buildTwoChoiceButton({
    required int stateValue,
    required int buttonValue,
    required String text,
    required VoidCallback onTap,
  }) {
    bool isSelected = (stateValue == buttonValue);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
              // 🌟 [수정] 선택 시 텍스트 색상을 white로 변경
              color: isSelected ? Colors.white : AuraColors.gray600,
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
              // 🌟 [수정] 선택 시 텍스트 색상을 white로 변경
              color: isSelected ? Colors.white : AuraColors.gray600,
              fontSize: (text == '30분 미만' || text == '30분 이상') ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }
}