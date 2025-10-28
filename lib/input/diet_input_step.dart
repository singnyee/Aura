// lib/input/diet_input_step.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import 'sleep_input_step.dart'; // _InputHeader, _FooterButton 재사용을 위해 import

class DietInputStep extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;

  const DietInputStep({
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
            title: '오늘의 식습관을 기록해볼까요? 🍽️',
            subtitle: '섭취 패턴은 감정 예보 정확도에 도움이 돼요.',
            progress: progress,
            currentStep: currentStep,
            totalSteps: totalSteps,
          ),
          
          // Question 1: 카페인
          const _DietQuestionCard(
            title: '카페인을 섭취하셨나요?',
            icon: FontAwesomeIcons.coffee,
            iconBgGradient: LinearGradient(colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          const SizedBox(height: 15),

          // Question 2: 음주
          const _DietQuestionCard(
            title: '음주를 하셨나요?',
            icon: FontAwesomeIcons.wineGlass,
            iconBgGradient: LinearGradient(colors: [Color(0xFFE8E0F7), Color(0xFFDDD0F0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          const SizedBox(height: 15),

          // Question 3: 매운 음식 (이모지 아이콘은 Text 위젯으로 처리)
          const _DietQuestionCard(
            title: '매운 음식을 드셨나요?',
            emoji: '🌶️',
            iconBgColor: Color(0xFFFECACA), // bg-red-200
          ),
          const SizedBox(height: 15),

          // Question 4: 차가운 음식
          const _DietQuestionCard(
            title: '차가운 음식을 드셨나요?',
            emoji: '🧊',
            iconBgColor: Color(0xFFDBEAFE), // bg-blue-200
          ),
          const SizedBox(height: 15),

          // Question 5: 단 음식
          const _DietQuestionCard(
            title: '단 음식이나 고혈당 음식을 드셨나요?',
            emoji: '🍰',
            iconBgColor: Color(0xFFFEF9C3), // bg-yellow-200
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

class _DietQuestionCard extends StatefulWidget {
  final String title;
  final IconData? icon;
  final String? emoji;
  final LinearGradient? iconBgGradient;
  final Color? iconBgColor;

  const _DietQuestionCard({
    required this.title,
    this.icon,
    this.emoji,
    this.iconBgGradient,
    this.iconBgColor,
  }) : assert(icon != null || emoji != null); // 아이콘이나 이모지 중 하나는 있어야 함

  @override
  State<_DietQuestionCard> createState() => _DietQuestionCardState();
}

class _DietQuestionCardState extends State<_DietQuestionCard> {
  bool? isYesSelected; // null: 선택 안 됨, true: 예, false: 아니요

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: widget.iconBgColor,
                  gradient: widget.iconBgGradient,
                ),
                child: Center(
                  child: widget.icon != null
                      ? FaIcon(widget.icon, size: 12, color: Colors.white)
                      : Text(widget.emoji!, style: const TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ChoiceButton(
                  text: '예',
                  isSelected: isYesSelected == true,
                  onTap: () => setState(() => isYesSelected = true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ChoiceButton(
                  text: '아니요',
                  isSelected: isYesSelected == false,
                  onTap: () => setState(() => isYesSelected = false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceButton({required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.transparent : const Color(0xFFF3F4F6),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                )
              : null,
          boxShadow: isSelected ? [
            BoxShadow(
              color: primaryPink.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ] : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF374151) : const Color(0xFF4B5563),
            ),
          ),
        ),
      ),
    );
  }
}