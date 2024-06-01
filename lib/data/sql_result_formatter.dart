class SQLResultFormatter {
  static Map<int, Map<String, List<dynamic>>> sessionResultFormat(
    List<Map<String, dynamic>> rawData,
  ) {
    Map<int, Map<String, List<dynamic>>> formattedData = {};
    for (var value in rawData) {
      int sessionID = value['session_id'];
      if (formattedData.containsKey(sessionID)) {
        formattedData[sessionID]!['reps']!.add(value['reps']);
        formattedData[sessionID]!['weights']!.add(value['weight']);
      } else {
        formattedData[sessionID] = {
          'reps': [value['reps']],
          'weights': [value['weight']],
        };
      }
    }
    return formattedData;
  }
}
