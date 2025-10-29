import 'package:flutter/material.dart';

// 1. 우리가 만든 홈 스크린 파일을 import 합니다.
import 'screens/home/home_screen.dart'; 

// 2. 테마 설정을 위해 색상 파일을 import 합니다.
import 'utils/aura_colors.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 3. 앱 제목
      title: '아우라 (Aura)',
      
      // 4. 디버그 리본 배너 제거
      debugShowCheckedModeBanner: false,
      
      // 5. 앱의 전반적인 테마 설정
      theme: ThemeData(
        // HTML의 <head>에서 사용한 'Pretendard' 폰트를 기본 폰트로 지정
        // (참고: 이 폰트를 사용하려면 pubspec.yaml에 폰트 파일 추가가 필요합니다)
        fontFamily: 'Pretendard',
        
        // 앱의 기본 배경색 (HTML의 <body> 배경)
        scaffoldBackgroundColor: Colors.white,
        
        // 앱의 메인 색상 (버튼 등에 사용)
        primaryColor: AuraColors.primaryPink,
        
        useMaterial3: true,
      ),
      
      // 6. 앱이 시작될 때 보여줄 첫 화면
      home: const HomeScreen(),
    );
  }
}