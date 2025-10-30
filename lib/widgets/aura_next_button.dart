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
        // 🌟 [수정]
        // 기존: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0)
        // 버튼 자체의 패딩(vertical: 24)과 중복되어 높이 오버플로우를 일으키므로
        // 여기서는 좌우 패딩만 남기고 세로 패딩은 제거합니다.
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              // 이 패딩이 버튼의 실제 높이를 결정합니다. (상: 24, 하: 24)
              padding: const EdgeInsets.symmetric(vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // 최소 너비를 'double.infinity'로 설정하여
              // 부모 위젯(Container)의 최대 너비를 꽉 채우게 합니다.
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
