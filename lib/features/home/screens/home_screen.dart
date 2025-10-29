import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_section.dart';
import '../widgets/emotion_forecast_section.dart';
import '../widgets/ai_routine_section.dart';
import '../widgets/today_record_section.dart';
import '../widgets/body_rhythm_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), // 최대 너비 제한
              child: const Padding(
                padding: EdgeInsets.only(bottom: 80.0), // 하단 네비게이션 공간 확보
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24), // px-6
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EmotionForecastSection(),
                          SizedBox(height: 24),
                          AIRoutineSection(),
                          SizedBox(height: 24),
                          TodayRecordSection(),
                          SizedBox(height: 24),
                          BodyRhythmSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}