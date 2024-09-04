import 'package:flutter/material.dart';

class DayGrid extends StatelessWidget {
  final DateTime date;

  const DayGrid({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    int daysInMonth = _getDaysInMonth(date.year, date.month);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 days in a week
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: daysInMonth,
        itemBuilder: (BuildContext context, int index) {
          int dayNumber = index + 1;

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xffE8EAEE), // Gray background color
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "$dayNumber",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  int _getDaysInMonth(int year, int month) {
    // This method calculates the number of days in the given month
    return DateTimeRange(
      start: DateTime(year, month),
      end: DateTime(year, month + 1),
    ).duration.inDays;
  }
}
