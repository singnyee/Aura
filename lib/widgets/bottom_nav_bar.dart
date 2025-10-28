import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart'; // 색상 상수 import

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold의 bottomNavigationBar에 사용
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1.0)), // border-t border-gray-100
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _NavItem(icon: FontAwesomeIcons.house, label: '홈', isSelected: true),
          _NavItem(icon: FontAwesomeIcons.calendar, label: '기록', isSelected: false),
          _NavItem(icon: FontAwesomeIcons.robot, label: 'AI 루틴', isSelected: false),
          _NavItem(icon: FontAwesomeIcons.chartLine, label: 'AI 리포트', isSelected: false),
          _NavItem(icon: FontAwesomeIcons.user, label: '마이', isSelected: false),
        ],
      ),
    );
  }
}

// 🌟 하위 위젯: NavItem
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavItem({required this.icon, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? primaryPink : const Color(0xFF9CA3AF); // primary-pink or gray-400

    return Column(
      mainAxisSize: MainAxisSize.min, // 공간 최소화
      children: [
        FaIcon(icon, color: color, size: 18), // text-lg
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10, // text-xs
            color: color,
          ),
        ),
      ],
    );
  }
}