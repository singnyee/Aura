// lib/screens/diet_survey_screen.dart

import 'package:flutter/material.dart';
import '../widgets/diet_question_section.dart'; // 질문 위젯 import

// 각 항목별 빈도 이넘 정의 (PMS 연구 결과를 구체적으로 반영)
enum SugarFrequency { never, weeklyOneTwo, weeklyFiveSix, daily } // 단순당
enum ProcessedFatFrequency { never, rarely, sometimes, often }    // 정제된 지방
enum SaltyFrequency { never, rarely, sometimes, often }           // 소금/짠 음식
enum CaffeineIntake { none, onePerDay, twoPerDay, threePlus }      // 카페인
enum AlcoholFrequency { none, monthly, weekly, twoPlusWeekly }    // 알코올

class DietSurveyScreen extends StatefulWidget {
  const DietSurveyScreen({super.key});

  @override
  State<DietSurveyScreen> createState() => _DietSurveyScreenState();
}

class _DietSurveyScreenState extends State<DietSurveyScreen> {
  // --- 상태 변수 정의: 사용자의 응답을 저장 ---
  SugarFrequency? _simpleSugar = SugarFrequency.never;
  ProcessedFatFrequency? _processedFat = ProcessedFatFrequency.never;
  SaltyFrequency? _saltyFood = SaltyFrequency.never;
  CaffeineIntake? _caffeine = CaffeineIntake.none;
  AlcoholFrequency? _alcohol = AlcoholFrequency.none;
  double _alcoholAmount = 0.0; // 1회 음주 시 주량 (Slider 값)

  // 서버 데이터 전송 및 GPT 호출 함수
  void _submitData() {
    final userData = {
      // Enum 값을 문자열로 변환하여 전송 (Spring 서버에서 쉽게 파싱 가능)
      'simpleSugarFrequency': _simpleSugar.toString().split('.').last,
      'processedFatFrequency': _processedFat.toString().split('.').last,
      'saltyFoodFrequency': _saltyFood.toString().split('.').last,
      'caffeineIntake': _caffeine.toString().split('.').last,
      'alcoholFrequency': _alcohol.toString().split('.').last,
      'alcoholAmount': _alcoholAmount, // 슬라이더 값
    };
    
    // TODO: 1. 여기서 실제 Spring 서버 API 호출 (POST 요청) 로직을 구현합니다.
    print('PMS 분석을 위해 서버로 전송할 데이터: $userData');
    
    // 예시: API 호출 성공 후 결과 화면으로 이동
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendationScreen()));
  }

  // 주량 선택을 위한 슬라이더 위젯
  Widget _buildAlcoholAmountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 12.0, bottom: 8.0),
          child: Text(
            '주량 선택 (1회 음주 시 잔/병 수)',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF673AB7),
            ),
          ),
        ),
        Slider(
          value: _alcoholAmount,
          min: 0,
          max: 10, // 최대 주량 설정
          divisions: 20, // 0.5 단위로 조절
          label: _alcoholAmount.toStringAsFixed(1),
          onChanged: (double value) {
            setState(() {
              _alcoholAmount = value;
            });
          },
          activeColor: const Color(0xFF673AB7),
        ),
        Center(
          child: Text(
            '선택된 주량: ${_alcoholAmount.toStringAsFixed(1)} 잔/병',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(height: 1, thickness: 1, indent: 8, endIndent: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('식습관 조사 (PMS 맞춤)'),
        backgroundColor: const Color(0xFF673AB7),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. 단순당/설탕 섭취 빈도 (가장 중요한 PMS 위험 증가 요인)
            DietQuestionSection(
              title: '🍰 단순당/설탕 섭취 빈도',
              subtitle: '꿀, 설탕, 아이스크림 등 단맛이 강한 음식/음료 섭취 빈도를 선택해 주세요.',
              options: const {
                SugarFrequency.never: '거의 안 먹음',
                SugarFrequency.weeklyOneTwo: '주 1~2회 (PMS 위험 2.9배 증가 요인 근접)',
                SugarFrequency.weeklyFiveSix: '주 5~6회 이상 (PMS 위험 2.27~2.46배 증가 요인)',
                SugarFrequency.daily: '매일 섭취함',
              },
              groupValue: _simpleSugar,
              onChanged: (value) {
                setState(() { _simpleSugar = value; });
              },
            ),

            // 2. 정제된 지방/튀긴 음식 섭취 빈도
            DietQuestionSection(
              title: '🍟 정제된 지방/튀긴 음식 섭취 빈도',
              subtitle: '단순당, 정제된 지방, 튀긴 음식은 PMS 발달과 관련이 있습니다.',
              options: const {
                ProcessedFatFrequency.never: '거의 안 먹음',
                ProcessedFatFrequency.rarely: '월 1~2회',
                ProcessedFatFrequency.sometimes: '주 1~3회',
                ProcessedFatFrequency.often: '주 4회 이상',
              },
              groupValue: _processedFat,
              onChanged: (value) {
                setState(() { _processedFat = value; });
              },
            ),

            // 3. 짠 음식 (소금) 섭취 빈도
            DietQuestionSection(
              title: '🧂 짠 음식 (소금) 섭취 빈도',
              subtitle: '소금 섭취를 최소화하는 것이 권장됩니다.',
              options: const {
                SaltyFrequency.never: '싱겁게 먹는 편',
                SaltyFrequency.rarely: '가끔 짠 음식을 먹음',
                SaltyFrequency.sometimes: '자주 짠 음식을 먹음',
                SaltyFrequency.often: '매우 짜게 먹는 편',
              },
              groupValue: _saltyFood,
              onChanged: (value) {
                setState(() { _saltyFood = value; });
              },
            ),

            // 4. 카페인 섭취량
            DietQuestionSection(
              title: '☕️ 카페인 섭취량',
              subtitle: '카페인 섭취를 최소화하는 것이 권장됩니다.',
              options: const {
                CaffeineIntake.none: '안 마심',
                CaffeineIntake.onePerDay: '하루 1잔',
                CaffeineIntake.twoPerDay: '하루 2잔',
                CaffeineIntake.threePlus: '하루 3잔 이상',
              },
              groupValue: _caffeine,
              onChanged: (value) {
                setState(() { _caffeine = value; });
              },
            ),

            // 5. 알코올 (음주) 섭취 빈도
            DietQuestionSection(
              title: '🍷 알코올 섭취 빈도',
              subtitle: '알코올은 PMS 발달과 양의 상관관계를 가집니다.',
              options: const {
                AlcoholFrequency.none: '안 함',
                AlcoholFrequency.monthly: '월 1회 미만',
                AlcoholFrequency.weekly: '월 1~4회',
                AlcoholFrequency.twoPlusWeekly: '주 2회 이상',
              },
              groupValue: _alcohol,
              onChanged: (value) {
                setState(() { _alcohol = value; });
              },
            ),

            // 6. 주량 선택 (음주를 한다고 선택했을 경우에만 표시)
            if (_alcohol != AlcoholFrequency.none) _buildAlcoholAmountSlider(),

            const SizedBox(height: 30),

            // 데이터 전송 버튼
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '데이터 저장 및 GPT 추천 요청',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}