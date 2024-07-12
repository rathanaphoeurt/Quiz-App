import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  QuizScreen({required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _selectedOptionIndex = -1;

  void _nextQuestion() {
    if (_selectedOptionIndex == -1) return;
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    List<Question> questions = quizProvider.getQuestions(widget.category);
    if (_selectedOptionIndex == questions[_currentQuestionIndex].correctOptionIndex) {
      quizProvider.updateScore(25);
    }
    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex = -1;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(category: widget.category)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    List<Question> questions = quizProvider.getQuestions(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Set 1'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                questions[_currentQuestionIndex].questionText,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              ...questions[_currentQuestionIndex].options.asMap().entries.map((entry) {
                int idx = entry.key;
                String text = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: _selectedOptionIndex == idx ? Colors.white : Colors.black, backgroundColor: _selectedOptionIndex == idx ? Colors.purple.shade700 : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedOptionIndex = idx;
                      });
                    },
                    child: Text(text, style: TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _nextQuestion,
                child: Text(
                  _currentQuestionIndex == questions.length - 1 ? 'Finish' : 'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
