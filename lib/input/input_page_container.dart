// lib/input/input_page_container.dart
import 'package:flutter/material.dart';
import 'sleep_input_step.dart';
import 'diet_input_step.dart';

class InputPageContainer extends StatefulWidget {
  const InputPageContainer({super.key});

  @override
  State<InputPageContainer> createState() => _InputPageContainerState();
}

class _InputPageContainerState extends State<InputPageContainer> {
  int _currentStep = 1;
  final int _totalSteps = 5; // HTML 기준 5단계

  void _goToNextStep() {
    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
    } else {
      // 모든 단계 완료 후 다음 화면으로 이동 (예: 홈 화면)
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    // HTML body의 배경 그라데이션
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // HTML: bg-gradient-to-br from-pink-50 to-purple-50
            colors: [Color(0xFFFDF2F8), Color(0xFFFAF5FF)], 
          ),
        ),
        // HTML: max-w-sm mx-auto bg-white/90 backdrop-blur-sm
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              color: Colors.white.withOpacity(0.95), // 배경색과 블러 효과 근사치
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 현재 단계에 따라 다른 화면을 보여줍니다.
                      if (_currentStep == 1) 
                        SleepInputStep(
                          currentStep: _currentStep,
                          totalSteps: _totalSteps,
                          onNext: _goToNextStep,
                        ),
                      if (_currentStep == 2) 
                        DietInputStep(
                          currentStep: _currentStep,
                          totalSteps: _totalSteps,
                          onNext: _goToNextStep,
                        ),
                      // ... 나머지 단계 위젯 추가 예정
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}