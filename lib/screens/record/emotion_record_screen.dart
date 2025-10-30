import 'package:flutter/material.dart';
import '../../utils/aura_colors.dart';
import '../../widgets/aura_next_button.dart';
import 'symptom_record_screen.dart';

class EmotionRecordScreen extends StatefulWidget {
  const EmotionRecordScreen({super.key});

  @override
  State<EmotionRecordScreen> createState() => EmotionRecordScreenState();
}

class EmotionRecordScreenState extends State<EmotionRecordScreen> {
  // HTML의 JS 로직을 Flutter 상태로 관리
  String selectedEmotion = ""; // 감정 (단일 선택)
  // Set<String> selectedSymptoms = {}; // [삭제됨]
  String userTypedText = ""; // 사용자가 입력 중인 텍스트

  // 텍스트필드 컨트롤러
  final TextEditingController emotionTextController = TextEditingController();

  // 컨트롤러 리스너 추가 (HTML의 input 이벤트와 동일)
  @override
  void initState() {
    super.initState();
    emotionTextController.addListener(() {
      setState(() {
        userTypedText = emotionTextController.text;
      });
    });
  }

  @override
  void dispose() {
    emotionTextController.dispose();
    super.dispose();
  }

  // [삭제됨] handleSymptomTap 함수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌟 body의 그라데이션 배경 적용
      body: Container(
        decoration: const BoxDecoration(
          gradient: pastelBodyGradient,
        ),
        child: buildMainContent(),
      ),
      // 공통 '다음으로' 버튼 재사용
      bottomNavigationBar: AuraNextButton(
        onPressed: () {
          // '증상 기록' 화면으로 이동하는 로직을 추가합니다.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SymptomRecordScreen(),
            ),
          );
        },
      ),
    );
  }

  // Scaffold의 body가 되는 메인 콘텐츠
  Widget buildMainContent() {
    // 🌟 배경색이 흰색인 메인 컨테이너 (HTML의 max-w-md ... bg-white)
    return SafeArea(
      bottom: false, // 하단 버튼 영역은 SafeArea에서 제외
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12), // 좌우 여백
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
            const SizedBox(height: 48), // pt-12
            buildProgressBar(), // Step 4 of 5
            const SizedBox(height: 24),
            buildHeaderTitle(),
            const SizedBox(height: 24),
            buildEmotionSection(), // 1. 감정 선택
            // const SizedBox(height: 32), // [삭제됨]
            // buildSymptomSection(), // [삭제됨]
            const SizedBox(height: 32),
            buildChatSection(), // 3. 챗봇형 텍스트 입력 (번호 수정은 안 함)
            const SizedBox(height: 120), // 하단 여백 (AuraNextButton 위로 스크롤되도록)
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
          'Step 4 of 5', // 🌟 수정
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AuraColors.gray600,
          ),
        ),
        const SizedBox(height: 12), // mb-3
        Container(
          height: 8, // h-2
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8, // 🌟 80%
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: softGradient, // 🌟 새 그라데이션
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
          '오늘의 감정에 대해 알려주세요 💗', // 🌟 수정
          style: TextStyle(
            fontSize: 20, // text-xl
            fontWeight: FontWeight.w600, // font-semibold
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'AI가 감정 변화를 분석해 마음 건강 리포트를 만들어드릴게요.', // 🌟 수정
          style: TextStyle(
            fontSize: 14,
            color: AuraColors.gray600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // 1. 감정 선택 섹션
  Widget buildEmotionSection() {
    return buildQuestionCard(
      title: '오늘 느낀 감정을 선택해주세요.',
      // 🌟 2열 그리드 (GridView.count)
      child: GridView.count(
        crossAxisCount: 2, // 2열
        shrinkWrap: true, // ListView 안에서 크기를 맞춤
        physics: const NeverScrollableScrollPhysics(), // 스크롤 중복 방지
        crossAxisSpacing: 12, // gap-3
        mainAxisSpacing: 12, // gap-3
        childAspectRatio: 3.5 / 1, // 버튼 가로/세로 비율
        children: [
          buildEmotionButton('😊', '기쁨이에요', '기쁨'),
          buildEmotionButton('😢', '우울해요', '우울'),
          buildEmotionButton('😟', '불안해요', '불안'),
          buildEmotionButton('😤', '짜증나요', '짜증'),
          buildEmotionButton('😌', '행복해요', '행복'),
          buildEmotionButton('😐', '보통이에요', '보통'),
        ],
      ),
    );
  }

  // [삭제됨] buildSymptomSection 함수

  // 3. 챗봇형 텍스트 입력 섹션
  Widget buildChatSection() {
    return buildQuestionCard(
      title: '', // 제목 없음
      padding: const EdgeInsets.all(16), // p-4 (디자인에 맞게 살짝 줄임)
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
                    bottomLeft: Radius.circular(4), // rounded-bl-sm
                  ),
                ),
                child: const Text(
                  '💬 오늘 하루, 어떤 일 때문에\n그런 감정을 느꼈나요?',
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

          // 🌟 사용자 입력 채팅 버블 (입력 중일 때만 보임)
          Visibility(
            visible: userTypedText.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AuraColors.gray100, // bg-gray-100
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(4), // rounded-br-sm
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6, // 최대 너비
                    ),
                    child: Text(
                      userTypedText, // 🌟 컨트롤러와 연결된 상태 변수
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
            controller: emotionTextController,
            maxLines: 3, // rows="3"
            decoration: InputDecoration(
              hintText: '여기에 입력해주세요...',
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

  // --- 헬퍼 위젯 ---

  // 질문 카드 공통 프레임
  Widget buildQuestionCard({required String title, required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // rounded-2xl
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
                fontSize: 18, // text-lg
                fontWeight: FontWeight.w500, // font-medium
                color: AuraColors.gray800,
              ),
            ),
          if (title.isNotEmpty)
            const SizedBox(height: 16), // mb-4
          child,
        ],
      ),
    );
  }

  // 감정 선택 버튼 (단일 선택)
  Widget buildEmotionButton(String emoji, String text, String key) {
    bool isSelected = (selectedEmotion == key);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmotion = key; // 단일 선택
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          // 🌟 선택/비선택 스타일
          color: isSelected ? AuraColors.pastelPink : Colors.transparent,
          border: Border.all(
            color: isSelected ? AuraColors.softPink : AuraColors.gray200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8), // mr-2
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

  // [삭제됨] buildSymptomButton 함수
}