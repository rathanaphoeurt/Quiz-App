import 'package:flutter/material.dart';
import 'dart:convert';

class ReviewScreen extends StatelessWidget {
  final Map<String, dynamic> history;

  ReviewScreen({required this.history});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> questions = history['questions'] != null ? List<dynamic>.from(json.decode(history['questions'])) : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Quiz - ${history['category']}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['questionText'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...List<Widget>.generate(question['options'].length, (optionIndex) {
                      bool isCorrect = optionIndex == question['correctOptionIndex'];
                      bool isSelected = optionIndex == question['selectedOptionIndex']; // Assuming selectedOptionIndex is stored
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              question['options'][optionIndex],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
