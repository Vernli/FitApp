import 'package:app/data/database/dao/exercise_dao.dart';

class ExerciseRepository {
  final ExerciseDAO _exerciseDAO = ExerciseDAO();

  ExerciseRepository();

  Future<void> setTrainingSession(String exerciseName, int day) async {
    await _exerciseDAO.setTrainingSession(exerciseName, day);
  }

  Future<void> setExerciseRepetitions(
    String exerciseName,
    int day,
    int reps,
    double weight,
  ) async {
    await _exerciseDAO.setExerciseRepetitions(exerciseName, day, reps, weight);
  }

  Future<List<Map<String, dynamic>>> getExerciseRepetitions(
    String exerciseName,
    int day,
  ) async {
    return await _exerciseDAO.getExerciseRepetitions(exerciseName, day);
  }

  Future<List<Map<String, dynamic>>> getAllTrainingSessions(
    String exerciseName,
  ) async {
    return await _exerciseDAO.getAllTrainingSessions(exerciseName);
  }

  Future<List<Map<String, dynamic>>> getTrainingSessions(
    String exerciseName,
    int count,
  ) async {
    return await _exerciseDAO.getTrainingSessions(exerciseName, count);
  }
}
