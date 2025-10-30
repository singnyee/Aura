import 'package:flutter/material.dart';
import '../utils/aura_colors.dart'; // 공통 색상 파일

class AuraNextButton extends StatelessWidget {
  // 버튼을 눌렀을 때 실행될 함수를 외부에서 받아옵니다.
  final VoidCallback onPressed;

  const AuraNextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // BottomAppBar + Padding + Container + ElevatedButton
    // 구조는 그대로 유지합니다.
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: pinkGradient, // 공통 그라데이션 사용
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AuraColors.primaryPink.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed, // 외부에서 받은 onPressed 함수 연결
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // 🌟 [해결책] 
              // 버튼의 최소 너비를 'double.infinity' (무한대)로 설정하여
              // 부모 위젯(Container)의 최대 너비를 꽉 채우게 합니다.
              // 높이는 0으로 설정하고, padding(py-4)이 높이를 결정하도록 합니다.
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Text(
              '다음으로 →',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}