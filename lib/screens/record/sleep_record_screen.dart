import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/aura_colors.dart'; 
import 'diet_record_screen.dart';
// 🌟 1. [추가] 새로 만든 공통 버튼을 import 합니다.
import '../../widgets/aura_next_button.dart'; 

// 🌟 2. [삭제] 
// 아래에 있던 const LinearGradient pinkGradient...
// const LinearGradient lavenderGradient... 2줄이 삭제되었습니다.
// (공통 파일인 aura_colors.dart 로 이동했기 때문입니다)

class SleepRecordScreen extends StatefulWidget {
  const SleepRecordScreen({super.key});

  @override
  State<SleepRecordScreen> createState() => SleepRecordScreenState();
}

class SleepRecordScreenState extends State<SleepRecordScreen> {
  TimeOfDay bedTime = const TimeOfDay(hour: 23, minute: 30);
  TimeOfDay wakeTime = const TimeOfDay(hour: 7, minute: 30);
  int selectedCondition = 0; 

  Future<void> selectTime(BuildContext context, bool isBedTime) async {
    final TimeOfDay initialTime = isBedTime ? bedTime : wakeTime;
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AuraColors.primaryPink, 
              onPrimary: Colors.white, 
              onSurface: AuraColors.gray800, 
            ),
            timePickerTheme: const TimePickerThemeData(
              dayPeriodTextColor: AuraColors.gray600,
              dayPeriodBorderSide: BorderSide(color: AuraColors.gray200),
              dayPeriodColor: Colors.transparent,
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              helpTextStyle: TextStyle(color: AuraColors.gray700),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AuraColors.primaryPink, 
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
          bedTime = picked;
        } else {
          wakeTime = picked;
        }
      });
    }
  }

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DietRecordScreen(),
            ),
          );
        },
      ),
    );
  }

  //
  // (이 아래 buildMainContent, buildProgressBar, buildHeaderTitle, 
  //  buildTimePickerCard, buildConditionCard, buildConditionButton 메서드는
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
        buildTimePickerCard(
          icon: FontAwesomeIcons.moon,
          gradient: pinkGradient,
          title: '취침 시각은 몇 시였나요?',
          time: bedTime,
          buttonColor: AuraColors.pinkEnd.withOpacity(0.5),
          onTap: () => selectTime(context, true),
        ),
        const SizedBox(height: 24), 
        buildTimePickerCard(
          icon: FontAwesomeIcons.sun,
          gradient: lavenderGradient,
          title: '기상 시각은 몇 시였나요?',
          time: wakeTime,
          buttonColor: const Color(0xFFEDE9F0), 
          onTap: () => selectTime(context, false),
        ),
        const SizedBox(height: 24), 
        buildConditionCard(), 
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
        const SizedBox(height: 8), 
        Container(
          height: 8, 
          decoration: BoxDecoration(
            color: AuraColors.gray200,
            borderRadius: BorderRadius.circular(99), 
          ),
          child: FractionallySizedBox(
            widthFactor: 0.2, 
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
          '어제 수면에 대해 알려주세요 🌙',
          style: TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600, 
            color: AuraColors.gray800,
          ),
        ),
        const SizedBox(height: 8), 
        Text(
          'AI가 수면 패턴을 분석해 감정 예보를 도와드릴게요.',
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

  Widget buildTimePickerCard({
    required IconData icon,
    required LinearGradient gradient,
    required String title,
    required TimeOfDay time,
    required Color buttonColor,
    required VoidCallback onTap,
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
        children: [
          Row(
            children: [
              Container(
                width: 32, 
                height: 32, 
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle, 
                ),
                child: Icon(icon, color: Colors.white, size: 14), 
              ),
              const SizedBox(width: 12), 
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w500, 
                  color: AuraColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), 

          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12), 
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), 
                      borderRadius: BorderRadius.circular(12), 
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
                const SizedBox(width: 12), 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(12), 
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

  Widget buildConditionCard() {
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
        children: [
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
          const SizedBox(height: 16), 
          Column(
            children: [
              buildConditionButton(0, '😊', '개운해요'),
              const SizedBox(height: 12), 
              buildConditionButton(1, '😐', '보통이에요'),
              const SizedBox(height: 12), 
              buildConditionButton(2, '😴', '피곤해요'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildConditionButton(int index, String emoji, String text) {
    bool isSelected = selectedCondition == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCondition = index; 
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16), 
        decoration: BoxDecoration(
          gradient: isSelected ? pinkGradient : null, 
          color: isSelected ? null : AuraColors.gray100, 
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8), 
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

  // 🌟 4. [삭제] 
  // 이 파일의 맨 아래에 있던 
  // Widget buildFooter() { ... } 메서드 전체가 삭제되었습니다.
}