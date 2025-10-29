import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/aura_colors.dart'; // 공통 색상 파일
import 'diet_record_screen.dart';

// HTML의 커스텀 그라데이션 정의
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

class SleepRecordScreen extends StatefulWidget {
  const SleepRecordScreen({super.key});

  @override
  // 🌟 수정: _SleepRecordScreenState -> SleepRecordScreenState
  State<SleepRecordScreen> createState() => SleepRecordScreenState();
}

// 🌟 수정: _SleepRecordScreenState -> SleepRecordScreenState
class SleepRecordScreenState extends State<SleepRecordScreen> {
  // 🌟 수정: State 변수에서 _ 제거
  TimeOfDay bedTime = const TimeOfDay(hour: 23, minute: 30);
  TimeOfDay wakeTime = const TimeOfDay(hour: 7, minute: 30);
  int selectedCondition = 0; // 0: 개운해요, 1: 보통, 2: 피곤해요

  // 🌟 수정: 메서드 이름에서 _ 제거
  Future<void> selectTime(BuildContext context, bool isBedTime) async {
    // 🌟 수정: _bedTime -> bedTime, _wakeTime -> wakeTime
    final TimeOfDay initialTime = isBedTime ? bedTime : wakeTime;
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        // 타임피커 테마
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AuraColors.primaryPink, // 헤더 배경
              onPrimary: Colors.white, // 헤더 텍스트
              onSurface: AuraColors.gray800, // 다이얼 숫자
            ),
            timePickerTheme: const TimePickerThemeData(
              // AM/PM 버튼
              dayPeriodTextColor: AuraColors.gray600,
              dayPeriodBorderSide: BorderSide(color: AuraColors.gray200),
              dayPeriodColor: Colors.transparent,
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // 확인/취소 버튼
              helpTextStyle: TextStyle(color: AuraColors.gray700),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AuraColors.primaryPink, // 버튼 텍스트
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBedTime) {
          // 🌟 수정: _bedTime -> bedTime
          bedTime = picked;
        } else {
          // 🌟 수정: _wakeTime -> wakeTime
          wakeTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FF), 
      // 🌟 수정: _buildMainContent -> buildMainContent
      body: buildMainContent(),
      // 🌟 수정: _buildFooter -> buildFooter
      bottomNavigationBar: buildFooter(),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildMainContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        const SizedBox(height: 48), // pt-12
        // 🌟 수정: _buildProgressBar -> buildProgressBar
        buildProgressBar(), // Progress Bar
        const SizedBox(height: 24), // mb-6
        // 🌟 수정: _buildHeaderTitle -> buildHeaderTitle
        buildHeaderTitle(), // Title Section
        const SizedBox(height: 24), // space-y-6
        // 🌟 수정: _buildTimePickerCard -> buildTimePickerCard
        buildTimePickerCard(
          icon: FontAwesomeIcons.moon,
          gradient: pinkGradient,
          title: '취침 시각은 몇 시였나요?',
          // 🌟 수정: _bedTime -> bedTime
          time: bedTime,
          buttonColor: AuraColors.pinkEnd.withOpacity(0.5),
          // 🌟 수정: _selectTime -> selectTime
          onTap: () => selectTime(context, true),
        ),
        const SizedBox(height: 24), // space-y-6
        // 🌟 수정: _buildTimePickerCard -> buildTimePickerCard
        buildTimePickerCard(
          icon: FontAwesomeIcons.sun,
          gradient: lavenderGradient,
          title: '기상 시각은 몇 시였나요?',
          // 🌟 수정: _wakeTime -> wakeTime
          time: wakeTime,
          buttonColor: const Color(0xFFEDE9F0), // purple-100
          // 🌟 수정: _selectTime -> selectTime
          onTap: () => selectTime(context, false),
        ),
        const SizedBox(height: 120), // space-y-6
        // 🌟 수정: _buildConditionCard -> buildConditionCard
        buildConditionCard(), // Question 3: 컨디션
        
      ],
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 1 of 5',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuraColors.gray600,
              ),
            ),
            Text(
              '20%',
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
            widthFactor: 0.2, // style="width: 20%"
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

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildHeaderTitle() {
    return Column(
      children: [
        Text(
          '어제 수면에 대해 알려주세요 🌙',
          style: TextStyle(
            fontSize: 22, // text-2xl
            fontWeight: FontWeight.w600, // font-semibold
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 8), // mb-2
        Text(
          'AI가 수면 패턴을 분석해 감정 예보를 도와드릴게요.',
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

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildTimePickerCard({
    required IconData icon,
    required LinearGradient gradient,
    required String title,
    required TimeOfDay time,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // bg-white/80
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        border: Border.all(color: AuraColors.lightPink.withOpacity(0.3)), // border-pink-100
        boxShadow: [
          BoxShadow(
            color: AuraColors.lightPink.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // 카드 헤더 (아이콘 + 제목)
          Row(
            children: [
              Container(
                width: 32, // w-8
                height: 32, // h-8
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle, // rounded-full
                ),
                child: Icon(icon, color: Colors.white, size: 14), // text-sm
              ),
              const SizedBox(width: 12), // mr-3
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18, // text-lg
                  fontWeight: FontWeight.w500, // font-medium
                  color: AuraColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // mb-4

          // 시간 선택 인풋
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                // 시간 표시 부분
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12), // py-3
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), // time-input
                      borderRadius: BorderRadius.circular(12), // rounded-xl
                      border: Border.all(color: const Color(0xFFFDE6E9), width: 2),
                    ),
                    child: Text(
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AuraColors.gray700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // space-x-3
                // AM/PM 표시 버튼
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // px-4 py-3
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(12), // rounded-xl
                  ),
                  child: Text(
                    time.period == DayPeriod.am ? 'AM' : 'PM',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: time.period == DayPeriod.am ? AuraColors.gray700 : AuraColors.primaryPink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildConditionCard() {
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
        children: [
          // 카드 헤더
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  gradient: pinkGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(FontAwesomeIcons.heart, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 12),
              const Text(
                '오늘 아침 컨디션은 어땠나요?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // mb-4

          // 선택 버튼
          Column(
            children: [
              // 🌟 수정: _buildConditionButton -> buildConditionButton
              buildConditionButton(0, '😊', '개운해요'),
              const SizedBox(height: 12), // space-y-3
              buildConditionButton(1, '😐', '보통이에요'),
              const SizedBox(height: 12), // space-y-3
              buildConditionButton(2, '😴', '피곤해요'),
            ],
          ),
        ],
      ),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
  Widget buildConditionButton(int index, String emoji, String text) {
    // 🌟 수정: _selectedCondition -> selectedCondition
    bool isSelected = selectedCondition == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          // 🌟 수정: _selectedCondition -> selectedCondition
          selectedCondition = index; // 상태 업데이트
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16), // py-4
        decoration: BoxDecoration(
          gradient: isSelected ? pinkGradient : null, // gradient-pink
          color: isSelected ? null : AuraColors.gray100, // bg-gray-100
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8), // space-x-2
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? AuraColors.gray700 : AuraColors.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🌟 수정: 메서드 이름에서 _ 제거
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DietRecordScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              '다음으로 →',
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w600, 
                fontSize: 18, 
              ),
            ),
          ),
        ),
      ),
    );
  }
}