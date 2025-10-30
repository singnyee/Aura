import 'package:flutter/material.dart';

class AuraColors {
  // --- 기존 색상 정의 ---
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

  // --- '감정 기록' 화면용 색상 ---
  static const Color pastelPink = Color(0xFFFFE8F0);
  static const Color pastelPurple = Color(0xFFF0E8FF);
  static const Color softPink = Color(0xFFFFB6D9);
  static const Color softPurple = Color(0xFFD4A5FF);
  static const Color lightGray = Color(0xFFF8F9FA); 
  
  // 🌟 [추가] AI 리포트용 색상 (Tailwind color palette 참고)
  static const Color pink600 = Color(0xFFDB2777);
  static const Color green600 = Color(0xFF16A34A);
  static const Color purple600 = Color(0xFF9333EA);
  static const Color blue800 = Color(0xFF1E40AF);
  static const Color pink400 = Color(0xFFF472B6);
  static const Color purple400 = Color(0xFFC084FC);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color pink200 = Color(0xFFFBCFE8);
  static const Color purple200 = Color(0xFFE9D5FF);
  static const Color purple50 = Color(0xFFFAF5FF); // bg-purple-50
  static const Color pink50 = Color(0xFFFDF2F8);   // bg-pink-50
}

// --- 기존 공통 그라데이션 ---
const LinearGradient pinkGradient = LinearGradient(
  colors: [Color(0xFFFDE6E9), Color(0xFFFBD6E0)], // 🌟 수정: HTML과 동일하게
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient lavenderGradient = LinearGradient(
  colors: [Color(0xFFE8E0F7), Color(0xFFD1C4E9)], // 🌟 수정: HTML과 동일하게
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

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

// 🌟 [추가] AI 리포트용 새 그라데이션
const LinearGradient reportPinkGradient = LinearGradient( // gradient-pink
  colors: [Color(0xFFFDE6E9), Color(0xFFFDB5C1)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient peachGradient = LinearGradient( // gradient-peach
  colors: [Color(0xFFFDE6E9), Color(0xFFFFE4B5)], 
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient progressGradient = LinearGradient( // 루틴 실행률 그라데이션
  colors: [AuraColors.purple400, AuraColors.pink400],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const LinearGradient feedbackButtonGradient = LinearGradient( // 마지막 버튼 그라데이션
  colors: [AuraColors.pink400, AuraColors.purple400],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);