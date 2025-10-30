import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/aura_colors.dart'; // 공통 색상 파일

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // --- 샘플 데이터 ---
  // 실제 앱에서는 백엔드나 로컬 저장소에서 불러와야 합니다.
  // key: 날짜(년-월-일), value: 감정 상태 (예: '기쁨', '우울')
  final Map<String, String> _emotionData = {
    '2025-10-27': '기쁨',
    '2025-10-28': '보통',
    '2025-10-29': '우울',
    '2025-10-30': '짜증', // 오늘
    // ... 다른 날짜들
  };

  // 감정에 따른 색상 매핑
  Color _getEmotionColor(String? emotion) {
    switch (emotion) {
      case '기쁨':
      case '행복':
        return AuraColors.pastelPink.withOpacity(0.7);
      case '우울':
      case '불안':
        return AuraColors.pastelPurple.withOpacity(0.7);
      case '짜증':
        return Colors.red.shade100.withOpacity(0.7);
      case '보통':
        return AuraColors.gray100.withOpacity(0.7);
      default:
        return Colors.transparent; // 기록 없는 날
    }
  }
  // --- 샘플 데이터 끝 ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('감정 기록 달력', style: TextStyle(color: AuraColors.gray800, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AuraColors.gray600), // 뒤로가기 버튼 색상
      ),
      backgroundColor: Colors.white, // 달력 배경은 흰색
      body: SingleChildScrollView( // 긴 달도 스크롤 가능하게
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableCalendar(
            locale: 'ko_KR', // 한국어 설정
            firstDay: DateTime.utc(2020, 1, 1), // 달력 시작일
            lastDay: DateTime.utc(2030, 12, 31), // 달력 종료일
            focusedDay: _focusedDay, // 현재 달력 카메라가 비추는 날짜
            selectedDayPredicate: (day) {
              // 선택된 날짜 표시 (선택 기능 사용 시)
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              // 날짜 선택 시 로직 (필요하면 구현)
              // setState(() {
              //   _selectedDay = selectedDay;
              //   _focusedDay = focusedDay; // 선택된 날짜로 포커스 이동
              // });
            },
            onPageChanged: (focusedDay) {
              // 달력 페이지(월) 넘길 때
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              // 오늘 날짜 스타일
              todayDecoration: BoxDecoration(
                color: AuraColors.softPink.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              // 선택된 날짜 스타일 (사용 안 함)
              selectedDecoration: BoxDecoration(
                color: AuraColors.primaryPink,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, // '2 weeks' 버튼 숨김
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            // 🌟 감정 색상 표시 로직
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // 날짜 'yyyy-MM-dd' 형식으로 변환
                final dayString = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
                final emotion = _emotionData[dayString]; // 해당 날짜의 감정 가져오기
                
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _getEmotionColor(emotion), // 감정 색상 적용
                    shape: BoxShape.circle, // 동그라미 모양
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      // 오늘 날짜는 굵게 표시 (위 todayDecoration과 겹치지 않게)
                      style: TextStyle(
                        fontWeight: isSameDay(day, DateTime.now()) ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
              // 오늘 날짜 마커는 위 defaultBuilder에서 처리했으므로 비워둠
              todayBuilder: (context, day, focusedDay) {
                 final dayString = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
                final emotion = _emotionData[dayString];
                 return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _getEmotionColor(emotion), 
                    border: Border.all(color: AuraColors.softPink, width: 2), // 오늘 테두리 강조
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                );
              },
              // 주말 스타일 등 필요시 추가
            ),
          ),
        ),
      ),
    );
  }
}