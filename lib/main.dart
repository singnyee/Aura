import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; 
import 'screens/report_screen.dart';
import 'input/input_page_container.dart'; // 설문 입력 화면 import

// 사용자 정의 색상 정의
const Color primaryPink = Color(0xFFF79FBF);
const Color lightPink = Color(0xFFF9C3D6);
const Color lavender = Color(0xFFF6EAFB);
const Color pinkEnd = Color(0xFFFDE7EE);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emotion Forecast App',
      
      theme: ThemeData(
        primaryColor: primaryPink,
        // fontFamily: 'Pretendard', // 폰트 설정 (필요시 주석 해제)
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      
      // 앱 시작 화면을 HomeScreen으로 변경
      home: const HomeScreen(), // 여기를 변경했습니다!
    );
  }
}
