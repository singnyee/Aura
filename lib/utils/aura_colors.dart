import 'package:flutter/material.dart';

class AuraColors {
  static const Color primaryPink = Color(0xFFF79FBF);
  static const Color lightPink = Color(0xFFF9C3D6);
  static const Color lavender = Color(0xFFF6EAFB);
  static const Color pinkEnd = Color(0xFFFDE7EE);

  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);

  // 🌟 [추가] '감정 기록' 화면용 새 색상
  static const Color pastelPink = Color(0xFFFFE8F0);
  static const Color pastelPurple = Color(0xFFF0E8FF);
  static const Color softPink = Color(0xFFFFB6D9);
  static const Color softPurple = Color(0xFFD4A5FF);
  static const Color lightGray = Color(0xFFF8F9FA); // 이건 gray50과 비슷
}

// 공통 그라데이션
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

// 🌟 [추가] '감정 기록' 화면용 새 그라데이션
const LinearGradient softGradient = LinearGradient(
  colors: [AuraColors.softPink, AuraColors.softPurple],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const LinearGradient pastelBodyGradient = LinearGradient(
  colors: [AuraColors.pastelPink, AuraColors.pastelPurple],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);