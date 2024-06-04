class CurrentDate {
  static Map<String, String> getDate() {
    final DateTime now = DateTime.now();

    final String formattedDate =
        '${now.year}-${addLeadingZeros(now.month)}-${addLeadingZeros(now.day)}';
    final String formattedTime =
        '${addLeadingZeros(now.hour)}:${addLeadingZeros(now.minute)}:${addLeadingZeros(now.second)}';
    print(formattedTime);
    return {
      'date': formattedDate,
      'time': formattedTime,
    };
  }

  static String addLeadingZeros(int value) {
    return value.toString().padLeft(2, '0');
  }
}
