// lib/widgets/report/report_header.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Font Awesome Icons 사용

class ReportHeader extends StatelessWidget {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 16), // px-6 pt-12 pb-4
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '리포트',
            style: TextStyle(
              fontSize: 24, // text-2xl
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937), // gray-800
            ),
          ),
          FaIcon(
            FontAwesomeIcons.calendarWeek,
            size: 20, // text-xl
            color: const Color(0xFF6B7280), // gray-500
          ),
        ],
      ),
    );
  }
}