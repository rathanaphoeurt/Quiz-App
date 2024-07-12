import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:quiz_app/helper/database_helper.dart';
import 'package:quiz_app/model/question.dart';
import 'package:intl/intl.dart';

class QuizProvider with ChangeNotifier {
  int _score = 0;
  int get score => _score;

  final Map<String, List<Question>> _questions = {
    'Flutter': [
      Question(
        questionText: 'What language does Flutter use?',
        options: ['Java', 'Kotlin', 'Dart', 'Swift'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'What is the main widget used in Flutter?',
        options: ['Container', 'Scaffold', 'Column', 'Row'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which company developed Flutter?',
        options: ['Apple', 'Google', 'Microsoft', 'Facebook'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'What is the command to create a new Flutter project?',
        options: ['flutter create', 'flutter new', 'flutter init', 'flutter start'],
        correctOptionIndex: 0,
      ),
    ],
    'React Native': [
      Question(
        questionText: 'Which language is used by React Native?',
        options: ['JavaScript', 'Python', 'Dart', 'Java'],
        correctOptionIndex: 0,
      ),
      Question(
        questionText: 'Who developed React Native?',
        options: ['Google', 'Facebook', 'Microsoft', 'Amazon'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'What is React Native primarily used for?',
        options: ['Web Development', 'Mobile Development', 'Game Development', 'AI Development'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which command is used to create a new React Native project?',
        options: ['react-native init', 'react-native new', 'react-native create', 'react-native start'],
        correctOptionIndex: 0,
      ),
    ],
    'Python': [
      Question(
        questionText: 'What type of language is Python?',
        options: ['Compiled', 'Interpreted', 'Machine', 'Markup'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which company created Python?',
        options: ['Microsoft', 'Apple', 'Google', 'Python Software Foundation'],
        correctOptionIndex: 3,
      ),
      Question(
        questionText: 'What is Python primarily used for?',
        options: ['Web Development', 'Data Science', 'Mobile Apps', 'System Programming'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which of the following is a Python web framework?',
        options: ['React', 'Django', 'Angular', 'Vue'],
        correctOptionIndex: 1,
      ),
    ],
    'C#': [
      Question(
        questionText: 'Which company developed C#?',
        options: ['Apple', 'Google', 'Microsoft', 'IBM'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'C# is primarily used for?',
        options: ['Web Development', 'Game Development', 'Data Analysis', 'Network Programming'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which of these is a feature of C#?',
        options: ['Automatic Garbage Collection', 'Manual Memory Management', 'Dynamic Typing', 'None of the above'],
        correctOptionIndex: 0,
      ),
      Question(
        questionText: 'Which IDE is commonly used for C# development?',
        options: ['IntelliJ IDEA', 'Visual Studio', 'PyCharm', 'Xcode'],
        correctOptionIndex: 1,
      ),
    ],
    'JavaScript': [
      Question(
        questionText: 'Which type of language is JavaScript?',
        options: ['Compiled', 'Interpreted', 'Machine', 'Markup'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Who developed JavaScript?',
        options: ['Microsoft', 'Apple', 'Netscape', 'Google'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'What is JavaScript primarily used for?',
        options: ['Server-side scripting', 'Client-side scripting', 'Game Development', 'Mobile Apps'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Which of the following is a JavaScript framework?',
        options: ['Django', 'Laravel', 'Spring', 'React'],
        correctOptionIndex: 3,
      ),
    ],
    'Vue.js': [
      Question(
        questionText: 'What type of framework is Vue.js?',
        options: ['Backend', 'Frontend', 'Mobile', 'Desktop'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'Who created Vue.js?',
        options: ['Evan You', 'Brendan Eich', 'Guido van Rossum', 'James Gosling'],
        correctOptionIndex: 0,
      ),
      Question(
        questionText: 'Vue.js is primarily used for?',
        options: ['Data Science', 'Game Development', 'UI Development', 'System Programming'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'Which of the following is a key feature of Vue.js?',
        options: ['Virtual DOM', 'Server-side rendering', 'TypeScript support', 'All of the above'],
        correctOptionIndex: 3,
      ),
    ],
  };

  List<Question> getQuestions(String category) {
    return _questions[category] ?? [];
  }

  void updateScore(int value) {
    _score += value;
    notifyListeners();
  }

  Future<void> saveQuizResult(String category) async {
    final dbHelper = DatabaseHelper();
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final formattedTime = DateFormat('hh:mm a').format(now);
    final row = {
      'category': category,
      'score': _score,
      'date': formattedDate,
      'time': formattedTime,
      'questions': json.encode(_questions[category]?.map((q) => q.toJson()).toList()),
    };
    await dbHelper.insertHistory(row);
  }

  Future<List<Map<String, dynamic>>> getQuizHistory() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.queryAllRows();
  }

  Future<void> deleteHistory(int id) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteHistory(id);
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
