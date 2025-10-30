import 'package:flutter/material.dart';
import '../../utils/aura_colors.dart'; 
import '../../widgets/aura_next_button.dart';

class SymptomRecordScreen extends StatefulWidget {
  const SymptomRecordScreen({super.key});

  @override
  State<SymptomRecordScreen> createState() => SymptomRecordScreenState();
}

class SymptomRecordScreenState extends State<SymptomRecordScreen> {
  // 상태 변수
  Set<String> selectedSymptoms = {}; // 신체 증상 (다중 선택)
  String userTypedCondition = ""; // 사용자가 입력 중인 컨디션 텍스트

  // 텍스트필드 컨트롤러
  final TextEditingController conditionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    conditionTextController.addListener(() {
      setState(() {
        userTypedCondition = conditionTextController.text;
      });
    });
  }

  @override
  void dispose() {
    conditionTextController.dispose();
    super.dispose();
  }

  // 신체 증상 버튼 탭 처리 로직 (감정 기록 화면과 동일)
  void handleSymptomTap(String symptom) {
    setState(() {
      if (symptom == "없음") {
        if (selectedSymptoms.contains("없음")) {
          selectedSymptoms.clear(); 
        } else {
          selectedSymptoms.clear(); 
          selectedSymptoms.add("없음"); 
        }
      } else {
        selectedSymptoms.remove("없음"); 
        
        if (selectedSymptoms.contains(symptom)) {
          selectedSymptoms.remove(symptom);
        } else {
          selectedSymptoms.add(symptom);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pastelBodyGradient, // 감정 기록 화면과 동일한 배경
        ),
        child: buildMainContent(),
      ),
      bottomNavigationBar: AuraNextButton(
        // 🌟 마지막 단계이므로 '완료하기' 텍스트로 변경
        // onPressed 구현은 잠시 비워둡니다.
        onPressed: () {
          // TODO: 모든 기록 데이터를 취합하여 저장하거나 다음 단계로 넘어가는 로직 구현
          // 예: Navigator.popUntil(context, ModalRoute.withName('/home')); // 홈 화면으로 돌아가기
          Navigator.popUntil(context, (route) => route.isFirst); // 가장 첫 화면(홈)으로 이동
        },
        // 🌟 버튼 텍스트 변경 옵션 추가 (AuraNextButton 위젯 수정 필요)
        // buttonText: '완료하기 🎉', 
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
            buildProgressBar(), // Step 5 of 5
            const SizedBox(height: 24), 
            buildHeaderTitle(), 
            const SizedBox(height: 24), 
            buildSymptomSelectionSection(), // 1. 증상 선택
            const SizedBox(height: 32), 
            buildConditionChatSection(), // 2. 컨디션 입력 (챗봇형)
            const SizedBox(height: 120), // 하단 여백
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
          'Step 5 of 5', // 🌟 수정
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
            widthFactor: 1.0, // 🌟 100%
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
          '오늘의 컨디션은 어떠셨나요? 🤔', // 🌟 수정
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w600, 
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 12), 
        Text(
          '신체 증상과 전반적인 컨디션을 기록해주세요.', // 🌟 수정
          style: TextStyle(
            fontSize: 14, 
            color: AuraColors.gray600,
            height: 1.5, 
          ),
        ),
      ],
    );
  }

  // 1. 신체 증상 선택 섹션
  Widget buildSymptomSelectionSection() {
    // 감정 기록 화면의 buildQuestionCard 와 buildSymptomButton 재사용
    return buildQuestionCard(
      title: '오늘 느낀 신체 증상을 모두 선택해주세요.',
      child: Column(
        children: [
          buildSymptomButton('🤒', '몸살 기운이 있어요', '몸살'),
          const SizedBox(height: 12),
          buildSymptomButton('🥶', '목/코감기 증상이 있어요', '감기'),
          const SizedBox(height: 12),
          buildSymptomButton('🖐️', '손발이 저릿저릿해요', '손발저림'),
          const SizedBox(height: 12),
          buildSymptomButton('🚫', '특별한 증상은 없어요', '없음'),
        ],
      ),
    );
  }

  // 2. 컨디션 입력 (챗봇형) 섹션
  Widget buildConditionChatSection() {
    // 감정 기록 화면의 buildChatSection과 거의 동일
    return buildQuestionCard(
      title: '', 
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // AI 채팅 버블
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  gradient: softGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(4), 
                  ),
                ),
                child: const Text(
                  '💬 전반적인 컨디션은 어떠셨나요?\n자유롭게 이야기해주세요.',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 14, 
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 사용자 입력 채팅 버블 (입력 중일 때만 보임)
          Visibility(
            visible: userTypedCondition.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AuraColors.gray100, 
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(4), 
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6, 
                    ),
                    child: Text(
                      userTypedCondition, 
                      style: const TextStyle(
                        color: AuraColors.gray800, 
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 텍스트 입력 필드
          TextField(
            controller: conditionTextController,
            maxLines: 3, 
            decoration: InputDecoration(
              hintText: '예: 몸이 좀 무겁고 피곤했어요.',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AuraColors.gray200, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AuraColors.gray200, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AuraColors.softPink, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 헬퍼 위젯 (감정 기록 화면에서 복사) ---

  Widget buildQuestionCard({required String title, required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24), 
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
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w500, 
                color: AuraColors.gray800,
              ),
            ),
          if (title.isNotEmpty)
            const SizedBox(height: 16), 
          child,
        ],
      ),
    );
  }

  Widget buildSymptomButton(String emoji, String text, String key) {
    bool isSelected = selectedSymptoms.contains(key);

    return GestureDetector(
      onTap: () {
        handleSymptomTap(key); 
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AuraColors.pastelPurple : Colors.transparent,
          border: Border.all(
            color: isSelected ? AuraColors.softPurple : AuraColors.gray200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 12), 
            Text(
              text, 
              style: const TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w500,
                color: AuraColors.gray800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}