// lib/input/sleep_input_step.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart'; // 색상 상수 import

class SleepInputStep extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;

  const SleepInputStep({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentStep / totalSteps;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Progress Bar & Title)
          _InputHeader(
            title: '어제 수면에 대해 알려주세요 🌙',
            subtitle: 'AI가 수면 패턴을 분석해 감정 예보를 도와드릴게요.',
            progress: progress,
            currentStep: currentStep,
            totalSteps: totalSteps,
          ),
          
          // Question 1: 취침 시각
          _TimeQuestionCard(
            icon: FontAwesomeIcons.moon,
            iconColor: Colors.white,
            iconBgGradient: const LinearGradient(
              colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            title: '취침 시각은 몇 시였나요?',
            initialTime: TimeOfDay(hour: 23, minute: 30),
            buttonText: 'PM',
            buttonColor: primaryPink.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          
          // Question 2: 기상 시각
          _TimeQuestionCard(
            icon: FontAwesomeIcons.sun,
            iconColor: Colors.white,
            iconBgGradient: const LinearGradient(
              colors: [Color(0xFFE8E0F7), Color(0xFFDDD0F0)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            title: '기상 시각은 몇 시였나요?',
            initialTime: TimeOfDay(hour: 7, minute: 30),
            buttonText: 'AM',
            buttonColor: const Color(0xFFEBE5F7),
            buttonTextColor: const Color(0xFF8B5CF6),
          ),
          const SizedBox(height: 20),
          
          // Question 3: 컨디션
          _ConditionQuestionCard(
            title: '오늘 아침 컨디션은 어땠나요?',
            options: const ['개운해요', '보통이에요', '피곤해요'],
            emojis: const ['😊', '😐', '😴'],
          ),

          // Footer Button
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 24.0),
            child: _FooterButton(text: '다음으로 →', onPressed: onNext),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------
// 💡 재사용 가능한 내부 위젯
// ---------------------------------------------------

class _InputHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final int currentStep;
  final int totalSteps;

  const _InputHeader({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Step $currentStep of $totalSteps',
                      style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563), fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(fontSize: 14, color: primaryPink),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE5E7EB), // bg-gray-200
                  valueColor: AlwaysStoppedAnimation<Color>(primaryPink),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          
          // Title Section
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

class _TimeQuestionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final LinearGradient iconBgGradient;
  final String title;
  final TimeOfDay initialTime;
  final String buttonText;
  final Color buttonColor;
  final Color? buttonTextColor;

  const _TimeQuestionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgGradient,
    required this.title,
    required this.initialTime,
    required this.buttonText,
    required this.buttonColor,
    this.buttonTextColor,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryPink, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Dialog background color
              onSurface: const Color(0xFF1F2937), // Text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryPink, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != initialTime) {
      // 시간 선택 로직 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // bg-white/80
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE6E9), width: 1), // border-pink-100
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: iconBgGradient,
                ),
                child: Center(
                  child: FaIcon(icon, size: 14, color: iconColor),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFDE6E9), width: 2),
                    ),
                    child: Text(
                      initialTime.format(context), // 선택된 시간 표시
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
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
                  buttonText,
                  style: TextStyle(
                    color: buttonTextColor ?? primaryPink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConditionQuestionCard extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> emojis;

  const _ConditionQuestionCard({
    required this.title,
    required this.options,
    required this.emojis,
  });

  @override
  State<_ConditionQuestionCard> createState() => _ConditionQuestionCardState();
}

class _ConditionQuestionCardState extends State<_ConditionQuestionCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE6E9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.heart, size: 14, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              final isSelected = selectedOption == option;
              
              return Padding(
                padding: EdgeInsets.only(top: index > 0 ? 12.0 : 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.transparent : const Color(0xFFF3F4F6), // bg-gray-100
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)],
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.emojis[index], style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? const Color(0xFF374151) : const Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _FooterButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryPink.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFF79FBF), Color(0xFFF9C3D6)], // gradient-pink 근사치
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}