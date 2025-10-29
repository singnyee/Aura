import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- Global Constants (Mocked from external files like main.dart) ---
const Color kPrimaryColor = Color(0xFFE94D62);
const Color primaryPink = Color(0xFFFDE6E9); // Lighter pink for selection border/shadow

// --- Mocked External Widgets (from sleep_input_step.dart or common/header.dart) ---

/// A mock implementation for the progress bar and title header.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        // Step Counter
        Text(
          'Step $currentStep of $totalSteps',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 24),
        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// A mock implementation for the main action button at the bottom.
class _FooterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _FooterButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          shadowColor: kPrimaryColor.withOpacity(0.3),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// --- Choice Button Component ---

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
              color: primaryPink.withOpacity(0.4),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ] : null,
          border: isSelected
              ? Border.all(color: const Color(0xFFF472B6), width: 1.5)
              : Border.all(color: Colors.transparent, width: 0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF374151) : const Color(0xFF4B5563),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Diet Question Card Component ---

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
                width: 32, // Slightly increased size
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.iconBgColor,
                  gradient: widget.iconBgGradient,
                ),
                child: Center(
                  child: widget.icon != null
                      ? FaIcon(widget.icon, size: 14, color: Colors.white)
                      : Text(widget.emoji!, style: const TextStyle(fontSize: 16)), // Increased emoji size
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
                ),
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

// --- Main Input Step Widget (Original request) ---

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
            icon: FontAwesomeIcons.mugSaucer, // Changed from coffee to mugSaucer for better icon
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

          // Question 3: 매운 음식 (Emoji)
          const _DietQuestionCard(
            title: '매운 음식을 드셨나요?',
            emoji: '🌶️',
            iconBgColor: Color(0xFFFCA5A5), // bg-red-300 for better contrast
          ),
          const SizedBox(height: 15),

          // Question 4: 차가운 음식 (Emoji)
          const _DietQuestionCard(
            title: '차가운 음식을 드셨나요?',
            emoji: '🧊',
            iconBgColor: Color(0xFF93C5FD), // bg-blue-300
          ),
          const SizedBox(height: 15),

          // Question 5: 단 음식 (Emoji)
          const _DietQuestionCard(
            title: '단 음식이나 고혈당 음식을 드셨나요?',
            emoji: '🍰',
            iconBgColor: Color(0xFFFCD34D), // bg-amber-300
          ),
          const SizedBox(height: 15),

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

// --- Main Application Wrapper ---

void main() {
  runApp(const DietInputApp());
}

/// The main application widget.
class DietInputApp extends StatelessWidget {
  const DietInputApp({super.key});

  // Mock function for onNext
  static void _handleNext() {
    // In a real app, this would navigate to the next step
    debugPrint('Diet Input Completed. Moving to the next step!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Input Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: DietInputStep(
              // Using mock step data for display purposes
              currentStep: 3,
              totalSteps: 5,
              onNext: _handleNext,
            ),
          ),
        ),
      ),
    );
  }
}
