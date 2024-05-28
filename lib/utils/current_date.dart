class CurrentDate {
  static Map<String, String> getDate() {
    final DateTime now = DateTime.now();
    final String formattedDate =
        '${now.year}-${now.month.toString().length == 1 ? '0${now.month}' : now.month}-${now.day}';
    final String formattedTime = '${now.hour}:${now.minute}:${now.second}';
    return {
      'date': formattedDate,
      'time': formattedTime,
    };
  }
}
